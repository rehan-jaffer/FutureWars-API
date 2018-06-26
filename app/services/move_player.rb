class MovePlayer
  prepend SimpleCommand

  def initialize(player_id, origin, dest)
    @player = Player.find(player_id)
    @origin = origin
    @dest = dest
  end

  def call
    unless Sector.is_connected?(@origin, @dest)
      errors.add(:player, 'These parts of space are not connected')
    end

    errors.add(:player, 'You have no turns left') unless @player.turns > 0

    unless @player.current_sector == @origin
      errors.add(:player, 'You are not in that sector mate')
    end

    if !errors.empty?
      return nil
    else
      return @player.turns
    end
  end
end
