module Mixins
  module Planet
    module Products
      def update_planet_products

        commodities = Hash.new(0)

        Port.commodities.each do |commodity|
          commodities[commodity] = attributes[commodity] + estimated_hourly_product(commodity)
        end

        update(commodities)

      end
    end
  end
end
