class DeployFightersService
  prepend SimpleCommand

  def initialize(player, fighter_count, mode="defensive")
    @player = player
    @fighter_count = fighter_count
    @mode = mode
  end

  def call
    policy = DeployFightersPolicy.new(@player, @fighter_count)
  
    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end
   
      sector_id = @player.current_sector
      sector = Sector.find(sector_id)
      sector.fighters_deployed += @fighter_count
      sector.fighters_player_id = @player.id
      sector.fighters_mode = @mode
      @player.primary_ship.fighters += @fighter_count
      sector.save && @player.save
      return sector
  end
end
