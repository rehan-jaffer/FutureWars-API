class ExpressWarpService
  prepend SimpleCommand
  
  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
  end

  def validates?
    errors.add(:errors, "Destination does not exist") unless Sector.exists?(@dest)
    errors.add(:errors, "You do not have enough turns") unless @player.can_express_warp?(@dest)
  end

  def call
    event = false
    @path = Warp.path(@player.current_sector, @dest)
    @sectors = []

    @path.shift

    while @path.any? && !event
      sector_id = @path.shift
      pp [sector_id, @player.current_sector]
      result = MovePlayerService.call(@player.id, sector_id)
      unless result.success?
        event = true
        errors.merge!(result.errors)
      else
        if @player.has_events?
          event = true
        else
          @player.update_sector(sector_id)
          @sectors.push(sector_id)
        end
      end
    end
    return @sectors
  end

end
