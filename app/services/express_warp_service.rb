class ExpressWarpService
  prepend SimpleCommand

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
  end

  def call
    @policy = ExpressWarpPolicy.new(@player, @dest)
    @policy.allowed? ? handle_success : handle_failure
  end

  def handle_success

    event = false
    @path = Warp.path(@player.current_sector, @dest)
    @sectors = []
    @path.shift
    express_warp

  end

  def handle_failure
    errors.add(:errors, @policy.error)
    return nil
  end

  def express_warp

    while @path.any? && !event
      sector_id = @path.shift
      result = MovePlayerService.call(@player.id, sector_id)
      sector_events = SectorEvents.new(Sector.find(sector_id), @player)
      if result.success?
        if sector_events.has_events?
          event = true
        else
          @player.update_sector(sector_id)
          @sectors.push(sector_id)
        end
      else
        event = true
        errors.merge!(result.errors)
      end
    end

  end

end
