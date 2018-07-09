class TradeWithPortService
  prepend SimpleCommand

  def initialize(sector_id, player_id, request = {})
    @sector_id = sector_id
    @player_id = player_id
    @req = request
  end

  def call
    sector = Sector.find(@sector_id)
    player = Player.find(@player_id)

    req = TradeRequest.new(player: player, sector: sector, request: @req)
    req.check

    if req.success?
#      Perform Transaction Here
#      sector["#{@commodity}_qty"] -= @qty
#      player.credits -= (@price * @qty)
      if sector.save && player.save
        return 'success'
      else
        req.errors
      end
    end
  end
end
