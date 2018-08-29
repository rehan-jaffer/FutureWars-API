require './lib/mixins/policy_object'

class DeployFightersPolicy

  include PolicyObject

  def initialize(player, fighter_count)
    @player = player
    @fighter_count = fighter_count
  end

  def conditions
    [
      ['Not enough fighters', !(@fighter_count > 0 && @fighter_count > @player.primary_ship.fighters)],
      ['Fighters not deployed here', !(@fighter_count < 0 && Sector.find(@player.current_sector).fighters_deployed < @fighter_count.abs)]
    ]
  end

end
