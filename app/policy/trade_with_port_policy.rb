require './lib/mixins/policy_object'

class TradeWithPortPolicy

  include PolicyObject

  def initialize(player, request, sector)
    @request = request
    @player = player
    @sector = sector
  end
  
  def conditions
    [
      ['Quantity must be supplied', @request.key?(:qty)],
      ['Must specify if you want to buy or sell', @request.key?(:trade_type) && %w[buy sell].include?(@request[:trade_type])],
      ['Commodity must be specified', (@request.key?(:commodity) && !@request[:commodity].empty?)],
      ['You do not have that many available holds', (@player.primary_ship.empty_holds >= @request[:qty].to_i)],
      ['We do not trade that commodity', @sector.port.trades?(@request[:trade_type], @request[:commodity])],
      ['We do not have that quantity', @sector.port.has_quantity?(@request[:commodity], @request[:qty])],
    ]
  end
end
