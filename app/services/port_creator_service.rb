require './lib/port_trade'
require './lib/ports/port_setup'

class PortCreatorService
  prepend SimpleCommand

  def initialize(props = {})
    @props = props
    @props[:port_class] = PortTradeString.get_class(@props.delete('trades')) if @props.key?('trades')
    @props[:name] = PlanetNamer.generate_one
  end

  def call
    policy = PortCreatorPolicy.new(@props[:sector_id], @props[:port_class])

    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end

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
