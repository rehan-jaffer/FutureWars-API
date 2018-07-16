class TradeWithPortService
  prepend SimpleCommand

  def initialize(player_id, request = {})
    @request = request
    @player = Player.find(player_id)
    @sector = Sector.find(@player.current_sector)
  end

  def validates?
    # check the request is valid

    errors.add(:errors, 'Quantity must be supplied') unless @request.key?(:qty)
    errors.add(:errors, 'Must specify if you want to buy or sell') unless @request.key?(:buy_or_sell) && %w[buy sell].include?(@request[:buy_or_sell])
    errors.add(:errors, 'Commodity must be specified') unless @request.key?(:commodity) && !@request[:commodity].empty?

    # check the request is feasible

    errors.add(:errors, 'We do not trade that commodity') unless @sector.port.trades?(@request[:buy_or_sell], @request[:commodity])
    errors.add(:errors, 'We do not have that quantity') unless @sector.port.has_quantity?(@request[:commodity], @request[:qty])
    errors.add(:errors, 'We do not want to trade with you') unless @player.can_trade_at_port?(@sector.id)
    errors.empty?
  end

  def call
    return errors unless validates?

    offer_price = 20 * @request[:qty].to_i

    transaction = Transaction.create(player_id: @player.id, port_id: @sector.port.id, open: true, status: :initial)
    offer = Offer.create(transaction_id: transaction.id, amount: offer_price)

    { transaction: transaction, initial_offer: offer }
  end
end
