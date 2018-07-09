class TradeRequest

  def initialize(player: player, sector: sector, request: request)
    @player = player
    @sector = sector
    @request = request
    @success = false
    @errors = []
  end

  def check

    # check the request is valid

    @errors.push("Quantity must be supplied") unless @request.has_key?(:qty)
    @errors.push("Must specify if you want to buy or sell") unless @request.has_key?(:buy_or_sell) && [:B, :S].include?(@request[:buy_or_sell])
    @errors.push("Commodity must be specified") unless @request.has_key?(:commodity) && !@request[:commodity].empty?

    # check the request is feasible

    @errors.push("We do not trade that commodity") unless @sector.port.trades?(@request[:buy_or_sell], @request[:commodity])
    @errors.push("We do not have that quantity") unless @sector.port.has_quantity?(@request[:commodity], @request[:qty])
    @errors.push("We do not want to trade with you") unless @player.can_trade_at_port?(@sector.id)

    return @errors if @errors.size > 0

    @success = true     
  end

  def success?
    @success
  end

  def errors
    @errors
  end

end
