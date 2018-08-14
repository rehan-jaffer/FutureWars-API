require './lib/port_trade'
require './lib/ports/port_setup'

class PortCreatorService
  prepend SimpleCommand

  def initialize(props = {})
    @props = props
    @props[:port_class] = PortTradeString.get_class(@props.delete('trades')) if @props.key?('trades')
    @props[:name] = PlanetNamer.generate_one
  end

  def validates?
    errors.add(:errors, 'Sector must exist') unless Sector.exists?(@props[:sector_id])
    errors.add(:errors, 'No Port Class supplied') unless @props[:port_class]
    errors.empty?
  end

  def call
    return nil unless validates?

    port = Port.create(@props)

    unless port.errors.empty?
      port.errors.full_messages.each do |error|
        errors.add(:errors, error)
      end
      return errors
    end

    PortSetup.initialize(port)
    port
  end
end
