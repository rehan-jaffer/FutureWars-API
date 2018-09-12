require './lib/events/event_emitter'
require './app/policy/consider_offer_policy'
require './lib/ports/port_transaction'

class ConsiderOfferService
  prepend SimpleCommand
  include EventEmitter

  def initialize(player, transaction_id, amount)
    @transaction = Transaction.where(uid: transaction_id).first
    @player = player
    @amount = amount.to_i
    @strategy = Rails.configuration.trading_strategy
    @offer_data = {
      amount: @amount,
      port_id: @transaction.port_id,
      initial_offer: @transaction.initial_offer,
      commodity: @transaction.commodity.to_sym,
      qty: @transaction.qty
    }
    @port = Port.find(@offer_data[:port_id])
    streams2 @player, @port
  end

  def call
    policy.allowed? ? handle_success : handle_failure
  end

  private
 
  def policy
    @policy ||= ConsiderOfferPolicy.new(@player, @transaction)
  end

  def handle_success

      unless @strategy.will_negotiate?(@offer_data)
        @transaction.reject!
        errors.add(:errors, 'Transaction terminated.')
        return nil
      end

      if @strategy.will_accept?(@offer_data)
          trade = PortTransaction.new(@port, @player, @transaction, @offer_data[:amount])
          trade.accept!
          emit :trade_accepted, trade_event_params
          return { transaction: @transaction.reload }
      end

      create_player_offer
      emit :trade_haggle, trade_event_params
      create_port_offer
  end

  def handle_failure
      emit :trade_rejected, trade_event_params
      errors.add(:errors, policy.error)
      return nil
  end

  def trade_event_params
    {
      player_id: @player.id, 
      port_id: @port.id, 
      qty: @offer_data[:qty], 
      amount: @offer_data[:amount], 
      commodity: @offer_data[:commodity]
    }
  end

  def create_player_offer
      Offer.create(transaction_id: @transaction.id, amount: @offer_data[:amount], actor_type: "player")
  end

  def create_port_offer
      { offer: Offer.create(transaction_id: @transaction.id, amount: @strategy.counter_offer(@offer_data), actor_type: "port") }
  end

end
