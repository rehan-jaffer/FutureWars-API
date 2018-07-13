class Port < ApplicationRecord
  # this is being re-used from lib/port_trade, remove duplication during refactoring
  PORT_TYPES = %w[Special BBS BSS BSB SBB SSB SBS BSS SSS BBB].freeze
  COMMODITIES = %w[ore organics equipment].freeze

  belongs_to :sector

  def has_quantity?(_commodity, _qty)
    # placeholder function
    true
  end

  def to_s
    PORT_TYPES[port_class]
  end

  def trades?(trade_type, commodity)
    choice = COMMODITIES.find_index(commodity)
    return false unless choice
    (trade_type[0].upcase == PORT_TYPES[port_class].split('')[choice])
  end
end
