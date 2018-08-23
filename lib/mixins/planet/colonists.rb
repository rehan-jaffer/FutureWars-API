require 'pp'

module Mixins
  module Planet
    module Colonists

      def assign_colonists(commodity, qty)
        return false if qty > unassigned_colonists || !Port.commodities.include?(commodity.to_s)
        update_attribute("#{commodity}_colonists", colonists_for(commodity) + qty)
        decrement(:unassigned_colonists, qty)
        true
      end

      def reassign_colonists(from, to, qty)
        return false unless qty < colonists_for(from) || (Port.commodities & [from, to].map(&:to_s)).any?
        update_attribute("#{to}_colonists", colonists_for(to) + qty)
        decrement("#{from}_colonists", qty)
        true
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
