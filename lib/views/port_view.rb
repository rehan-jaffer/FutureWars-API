require 'port_trade'

class PortView
  def self.render(attributes)
    return 'none' unless attributes['has_port']
    {
      name: attributes['port_name'],
      class: attributes['port_class'],
      trades: PortTradeString.get(attributes['port_class'])
    }
  end
end
