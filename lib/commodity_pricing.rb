module CommodityPricing
  def self.included(_mod)
    commodities = %i[ore equipment organics]
    commodities.each do |commodity|
      define_method "#{commodity}_price" do
        per_unit_price(commodity)
      end
    end
  end

  def per_unit_price(commodity)
    commodity = commodity.to_sym if commodity.is_a? String
    max = (pricing_constants[commodity][:mcic_coefficient] * organics_mcic) + 26.4
    ((max - pricing_constants[commodity][:unit_number]) / pricing_constants[commodity][:percentage_number]) * (trading_percent(commodity.to_sym) - pricing_constants[commodity][:percentage_number2]) + pricing_constants[commodity][:unit_number]
  end

  def pricing_constants
    {
      "ore": { mcic_coefficient: -0.193, unit_number: 25.60558, percentage_number: 88.2752, percentage_number2: 88.2752 },
      "organics": { mcic_coefficient: -0.193, unit_number: 25.60558, percentage_number: 88.2752, percentage_number2: 88.2752 },
      "equipment": { mcic_coefficient: -0.193, unit_number: 25.60558, percentage_number: 88.2752, percentage_number2: 88.2752 }
    }
  end
end
