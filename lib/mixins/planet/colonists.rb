module Mixins
  module Planet
    module Colonists
      def assign_colonists(commodity, qty)
        update_attribute("#{commodity}_colonists", attributes["#{commodity}_colonists"] + qty)
      end

      def estimated_daily_production(commodity)

      end
    end
  end
end
