class PortClass
  PORT_TYPES = %w[Special BBS BSS BSB SBB SSB SBS BSS SSS BBB].freeze
  COMMODITIES = %i[ore organics equipment].freeze

  def initialize(port_class)
    @port_class = port_class
  end

  def to_s
    PORT_TYPES[@port_class]
  end

  def trades?(trade_type, commodity)
    choice = COMMODITIES.find_index(commodity)
    return false unless choice
    (trade_type == PORT_TYPES[@port_class].split('')[choice].to_sym)
  end
end
