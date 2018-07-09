require 'pp'

class MovePlayerService
  prepend SimpleCommand

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
  end

  def call
    errors.add(:errors, 'These parts of space are not connected') unless Sector.connected?(@player.current_sector, @dest)
    errors.add(:errors, 'You have no turns left') unless @player.turns > 0
    errors.add(:errors, 'Not a valid sector ID') unless Sector.exists?(@dest)

    unless errors.key?(:errors)
      @player.turns -= 1
      @player.current_sector = @dest
      @player.save
      return true
    end

    nil
    #    Universe.event(:player_move, @player.id, [@origin, @dest])

    nil
  end
end
