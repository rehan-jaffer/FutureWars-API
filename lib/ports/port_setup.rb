require './lib/port_trade.rb'

class PortSetup
  def self.rand_productivity
    (rand * 150) + 150
  end

  def self.get_mcic(commodity, trade_type)
    commodity_ranges = { 'ore': (40..90), 'organics': (30..75), 'equipment': (20..65) }
    commodity_ranges[commodity.to_sym].to_a.sample * (trade_type == 'Buying' ? -1 : 1)
  end

  def self.initialize(port)
    Port.commodities.each do |commodity|
      port["#{commodity}_mcic"] = get_mcic(commodity, PortTradeCommodity.buys_or_sells(port.port_class, commodity))
      port["#{commodity}_productivity"] = rand_productivity
      port["#{commodity}_qty"] = port["#{commodity}_productivity"] * 10
    end

    port.save
  end
end
