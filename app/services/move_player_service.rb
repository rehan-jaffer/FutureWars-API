require './lib/events/event_emitter'

class MovePlayerService
  prepend SimpleCommand
  include EventEmitter

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @origin = @player.current_sector
    @dest = dest
    streams(['universe', "player_#{@player.id}"])
  end

  def validates?
    errors.add(:errors, 'These parts of space are not connected') unless Warp.connected?(@player.current_sector, @dest)
    errors.add(:errors, 'You have no turns left') unless @player.turns > 0
    errors.add(:errors, 'Not a valid sector ID') unless Sector.exists?(@dest)
    errors.empty?
  end

  def update_player_state
    @player.update_sector(@dest)
    @player.decrease_turns( @player.move_cost(1) )
  end

  def update_events
    emit_event(PlayerMoved, player_id: @player.id,
                            origin_id: @origin,
                            dest_id: @dest)
  end

  def call
    return nil unless validates?
    update_player_state
    update_events
    @player
  end
end
