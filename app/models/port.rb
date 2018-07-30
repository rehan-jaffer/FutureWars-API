class Port < ApplicationRecord
  include CommodityPricing

  belongs_to :sector

  def to_h
    attributes.merge(trading_hash)
  end

  def to_s
    port_types[port_class]
  end

  def trading_hash
    commodities.map { |k| ["#{k}_trading", trading_percent(k)] }.to_h
  end

  def trading_percent(commodity)
    ((attributes["#{commodity}_qty"] / (attributes["#{commodity}_productivity"] * 10.0)) * 100.0).round(1)
  end

  def has_quantity?(commodity, qty)
    qty.to_i < attributes["#{commodity}_qty"]
  end

  def trades?(trade_type, commodity)
    return false unless commodity.include?(commodity)
    (trade_type[0].upcase == port_types[port_class].split('')[commodities.find_index(commodity)])
  end

  private

  def port_types
    %w[Special BBS BSS BSB SBB SSB SBS BSS SSS BBB]
  end

  def commodities
    %w[ore organics equipment]
  end
end
