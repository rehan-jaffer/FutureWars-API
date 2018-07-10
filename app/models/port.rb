class Port
  # this is being re-used from lib/port_trade, remove duplication during refactoring

  def initialize(sector_attributes)
    @sector_attributes = sector_attributes
    @port_class = PortClass.new(sector_attributes['port_class'])
  end

  # Nasty function. Add tests and then refactor this
  def trades?(buy_or_sell, commodity)
    @port_class.trades?(buy_or_sell, commodity)
  end

  def has_quantity?(_commodity, _qty)
    # placeholder function
    true
  end
end
