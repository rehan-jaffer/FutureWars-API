require './lib/events/event_emitter'
require './app/policy/consider_offer_policy'

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
  end

  def call
    offer_policy = ConsiderOfferPolicy.new(@player, @transaction)

    if offer_policy.denied?
      errors.add(:errors, offer_policy.error)
      return nil
    end

    if offer_policy.allowed?
      unless @strategy.will_negotiate?(@offer_data)
        @transaction.reject!
        errors.add(:errors, 'Transaction terminated.')
        return nil
      end

      if @strategy.will_accept?(@offer_data)
        @port = Port.find(@offer_data[:port_id])
        @transaction.accept!

        case @transaction.trade_type
          when 'Buying'
            @player.ship.load_hold(@request[:commodity], @request[:qty])
            @player.decrease_credits(@offer_data[:amount])
            @port.accumulated_trading_credits += @offer_data[:amount]
          when 'Selling'
            @player.ship.jettison_holds(@request[:commodity], @request[:qty])
            @player.increase_credits(@offer_data[:amount])
          end

          return { transaction: @transaction }
        end

      { offer: Offer.create(transaction_id: @transaction.id, amount: @strategy.counter_offer(@offer_data)) }
    end
  end
end
