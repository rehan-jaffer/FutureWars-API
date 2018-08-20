require 'pp'

module Mixins
  module Planet
    module Colonists

      def assign_colonists(commodity, qty)
        return false if qty > unassigned_colonists
        update_attribute("#{commodity}_colonists", colonists_for(commodity) + qty)
      end

      def estimated_hourly_product(commodity)
        ((colonists_for(commodity.to_s).to_f / planet_type.attributes["colonists_#{commodity}_ratio"]) / 24.0).to_i
      end
     
      private

        def colonists_for(commodity)
          attributes["#{commodity}_colonists"]
        end
     
    end
  end
end
