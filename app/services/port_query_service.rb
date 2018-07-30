require './lib/views/port_trade_view'
require './lib/views/special_port_trade_view'

class PortQueryService
  prepend SimpleCommand

  PortQuery = Class.new(RailsEventStore::Event)

  def initialize(id, user)
    @id = id
    @player = user # remove
    @current_sector = user.current_sector
    @port = Port.where(sector_id: @id).first
    @streams = %w[trading universe port_queries]
  end

  def update_events
    event = PortQuery.new(data: { port_id: @port.id, sector_id: @sector.id, player_id: @player.id })
    @streams.each do |stream|
      Rails.configuration.event_store.publish(event, stream)
    end
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
