class MovePlayer
  prepend SimpleCommand

  def initialize(player_id, origin, dest)
    @player = Player.find(player_id)
    @origin = origin
    @dest = dest
  end

  def call
    errors.add(:player, 'These parts of space are not connected') unless Sector.connected?(@origin, @dest)
    errors.add(:player, 'You have no turns left') unless @player.turns > 0
    errors.add(:player, 'You are not in that sector mate') unless @player.current_sector == @origin

    @player.turns -= 1
    @player.current_sector = @dest
    @player.save

    return @player.turns if errors.empty?
    nil
  end
end
