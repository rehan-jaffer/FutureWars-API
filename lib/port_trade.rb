class PortTradeString
  def self.get(port_class)
    ['Special', 'BSS', 'BSB', 'SBB', 'SSB', 'SBS', 'BSS', 'SSS', 'BBB'][port_class]
  end
end

class PortTradeCommodity
  def self.buys_or_sells(port_class, commodity)
    commodities = ["ore", "organics", "equipment"]
    return nil unless commodities.include?(commodity)
    trades = PortTradeString.get(port_class).split("")[commodities.find_index(commodity)]
    return trades == "B" ? "Buying" : "Selling" 
  end
end
