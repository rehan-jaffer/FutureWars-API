require './lib/events/event_emitter'

class PortQueryService
  prepend SimpleCommand
  include EventEmitter

  def initialize(port_id, user)
    @port = Port.where(sector_id: port_id).first
    @player = user
    streams2 @port, @player
  end

  def update_events
    emit :port_query, port_id: @port.id, sector_id: @port.sector_id, player_id: @player.id
  end

  def call

    policy = PortQueryPolicy.new(@player, @port)

    if policy.denied?
      errors.add(:errors, policy.error)
    elsif policy.allowed?
      @port.to_json
    end

  end
end
