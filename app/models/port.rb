require './lib/trading/commodity_pricing'

class Port < ApplicationRecord
  include CommodityPricing

  belongs_to :sector

  def self.commodities
    %w[ore organics equipment]
  end

  def stream_id
    "port-#{id}"
  end

  def to_s
    port_types[port_class]
  end

  def trading_percent(commodity)
    ((qty_for(commodity) / (productivity_for(commodity) * 10.0)) * 100.0).round(1)
  end

  def has_quantity?(commodity, qty)
    commodity && (qty.to_i < qty_for(commodity))
  end

  def trades
    h = {}
    trading_letters(port_class).each_with_index do |c, i|
      h[commodities[i]] = c
    end
    h
  end

  def class_zero
    @class_zero ||= ClassZeroPort.new(self)
  end

  def trades?(trade_type, commodity)
    return false unless trade_type && commodity && commodity.include?(commodity)
    trade_letter = trade_type[0].upcase
    (trade_letter == trading_letters(port_class)[commodity_trade_index(commodity)])
  end

  private

  def qty_for(commodity)
    attributes["#{commodity}_qty"]
  end

  def productivity_for(commodity)
    attributes["#{commodity}_productivity"]
  end

  def commodity_trade_index(commodity)
    commodities.find_index(commodity)
  end

  def trading_letters(port_class)
    port_types[port_class].split('')
  end

  def port_types
    %w[Special BBS BSS BSB SBB SSB SBS BSS SSS BBB]
  end

  def commodities
    %w[ore organics equipment]
  end
end
