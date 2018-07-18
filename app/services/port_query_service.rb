require './lib/views/port_trade_view'
require './lib/views/special_port_trade_view'

class PortQueryService
  prepend SimpleCommand

  def initialize(id, current_sector)
    @id = id
    @current_sector = current_sector
    @port = Port.where(sector_id: @id).first
    @streams = ["trading", "universe","port_queries"]
  end

  def update_events
    event = Event.new({port_id: @port.id}, @streams)
    EventSource.publish(event, @streams)
  end

  def validates?
    errors.add(:errors, 'You are not in that sector! Cannot query port across sectors.') unless @id.to_i == @current_sector.to_i
    errors.add(:errors, 'No user supplied!') unless @id
    errors.empty?
  end

  def call
    return nil unless validates?
    return SpecialPortTradeView.render(@port.attributes) if @port && @port.port_class == 0
    PortTradeView.render(@port.attributes)
  end
end
