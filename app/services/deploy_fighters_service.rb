class DeployFightersService
  prepend SimpleCommand

  def initialize(player_id, fighter_count)
    @player = Player.find(player_id)
    @fighter_count = fighter_count
  end

  def validates?
    errors.add(:errors, 'You do not have that many fighters') if @fighter_count > 0 && @fighter_count > @player.primary_ship.fighters
    errors.add(:errors, 'Fighters not deployed') if @fighter_count < 0 && Sector.find(@player.current_sector).fighters < @fighter_count.abs
  end

  def call; end
end
