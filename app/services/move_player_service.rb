require './lib/events/event_emitter'

class MovePlayerService
  prepend SimpleCommand
  include EventEmitter

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @origin = @player.current_sector
    @dest = dest
    streams2 @player
  end

  def call
    policy.allowed? ? handle_success : handle_failure
  end

  private

  def policy
    @policy ||= MovePlayerPolicy.new(@player, @dest)
  end

  def handle_success
    @player.update_sector(@dest)
    @player.decrease_turns(@player.move_cost(1))
    emit :player_moved, player_id: @player.id,
                        origin_id: @origin,
                        dest_id: @dest
    return @player
  end

  def handle_failure
    errors.add(:errors, policy.error)
    nil
  end

end
