require './lib/events/event_emitter'

class PortQueryService
  prepend SimpleCommand
  include EventEmitter

  def initialize(id, user)
    @id = id
    @player = user # remove
    @current_sector = user.current_sector
    @port = Port.where(sector_id: @id).first
    streams(%w[trading universe port_queries])
  end

  def update_events
    emit_event(PortQuery, port_id: @port.id, sector_id: @sector.id, player_id: @player.id)
  end

  def validates?
    errors.add(:errors, 'You are not in that sector! Cannot query port across sectors.') unless @id.to_i == @current_sector.to_i
    errors.add(:errors, 'No user supplied!') unless @id
    errors.empty?
  end

  def call
    return nil unless validates?
    #    return SpecialPortTradeView.render(@port.attributes) if @port && @port.port_class == 0
    #    PortTradeView.render(@port.attributes)
    @port.to_json
  end
end
