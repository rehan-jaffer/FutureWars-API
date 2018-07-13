require './lib/port_trade'

class PortCreatorService
  prepend SimpleCommand

  def initialize(props = {})
    @props = props
    if @props.key?("trades")
      @props['port_class'] = PortTradeString.get_class(@props["trades"])
      @props.delete("trades")
    end
  end

  def call
    @props['name'] = PlanetNamer.generate_one
    port = Port.create(@props)
    return port if port.errors.empty?
    port.errors.full_messages.each do |error|
      errors.add(:errors, error)
    end
    nil
  end
end
