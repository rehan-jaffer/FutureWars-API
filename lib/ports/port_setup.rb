require './lib/port_trade.rb'
require 'pp'

class PortSetup
  def self.rand_productivity
    (rand * 150) + 150
  end

  def self.get_mcic(commodity, trade_type)

    commodity_ranges = {'ore': (40..90), 'organics': (30..75), 'equipment': (20..65)}  
    commodity_ranges[commodity.to_sym].to_a.sample * ((trade_type == "Buying") ? -1 : 1)

  end

  def self.initialize(port)

    commodities = ['ore', 'organics', 'equipment']

    commodities.each do |commodity|
      port["#{commodity}_mcic"] = get_mcic(commodity, PortTradeCommodity.buys_or_sells(port.port_class, commodity))
    end

    port.organics_productivity = rand_productivity
    port.ore_productivity = rand_productivity
    port.equipment_productivity = rand_productivity

    port.organics_qty = port.organics_productivity * 10
    port.ore_qty = port.ore_productivity * 10
    port.equipment_qty = port.equipment_productivity * 10

    port.save
  end
end
