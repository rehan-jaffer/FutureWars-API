require 'simple_command'

class TradeWithPortService
  prepend SimpleCommand

  def initialize(player_id, request)
    @request = request
    @player = Player.find(player_id)
    @sector = Sector.find(@player.current_sector)
    @strategy = Rails.configuration.trading_strategy
    @offer_data = { port_id: @sector.port.id }.merge(@request)
  end

  def call
    policy = TradeWithPortPolicy.new(@player, @request, @sector)
    
    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end

    offer_price = @strategy.initial_offer_price(@offer_data)
    transaction = Transaction.create(@request.merge(player_id: @player.id, port_id: @sector.port.id, open: true, status: :initial, initial_offer: offer_price))
    offer = Offer.create(transaction_id: transaction.id, amount: offer_price)
    { transaction: transaction, initial_offer: offer }
  end
end
