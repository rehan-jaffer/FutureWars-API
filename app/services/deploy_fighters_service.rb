class DeployFightersService
  prepend SimpleCommand

  def initialize(player, fighter_count)
    @player = player
    @fighter_count = fighter_count
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
      @player.primary_ship.fighters += @fighter_count
      sector.save && @player.save
      return sector
  end
end
