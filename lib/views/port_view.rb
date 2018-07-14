require 'port_trade'

class PortView
  def self.render(attributes)
    sector = Sector.find(attributes['id'])
    return 'none' unless sector.port
    {
      name: sector.port['name'],
      class: sector.port['port_class'],
      trades: PortTradeString.get(sector.port['port_class'])
    }
  end
end
