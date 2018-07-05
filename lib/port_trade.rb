class PortTradeString
  PORT_STRINGS = %w[Special BBS BSS BSB SBB SSB SBS BSS SSS BBB].freeze

  def self.get(port_class)
    PORT_STRINGS[port_class]
  end

  def self.get_class(port_string)
    PORT_STRINGS.find_index(port_string)
  end
end

class PortTradeCommodity
  def self.buys_or_sells(port_class, commodity)
    commodities = %w[ore organics equipment]
    return nil unless commodities.include?(commodity)
    trades = PortTradeString.get(port_class).split('')[commodities.find_index(commodity)]
    trades == 'B' ? 'Buying' : 'Selling'
  end
end
