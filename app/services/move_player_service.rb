require 'pp'

class MovePlayerService
  prepend SimpleCommand

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
  end

  def validates?
    errors.add(:errors, 'These parts of space are not connected') unless Sector.connected?(@player.current_sector, @dest)
    errors.add(:errors, 'You have no turns left') unless @player.turns > 0
    errors.add(:errors, 'Not a valid sector ID') unless Sector.exists?(@dest)
    errors.empty?
  end

  def update_state
    @player.turns -= 1
    @player.current_sector = @dest
    @player.save
  end

  def call

    return nil unless validates?

    update_state
    @player
  end
end
