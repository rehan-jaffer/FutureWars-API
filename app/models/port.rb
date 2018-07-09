class Port

  # this is being re-used from lib/port_trade, remove duplication during refactoring
  PORT_TYPES = %w[Special BBS BSS BSB SBB SSB SBS BSS SSS BBB]
  COMMODITIES = [:ore, :organics, :equipment]

  def initialize(sector_attributes)
    @sector_attributes = sector_attributes
  end

  # Nasty function. Add tests and then refactor this
  def trades?(buy_or_sell, commodity)

    choice = COMMODITIES.find_index(commodity)
    return false unless choice
    (buy_or_sell == PORT_TYPES[@sector_attributes["port_class"]].split("")[choice].to_sym)

  end

  def has_quantity?(commodity, qty)
    # placeholder function
    true
  end

end


