module Mixins
  module Ship
    module Holds

      def total_holds
        ship_type.base_holds + additional_holds
      end

      def empty_holds
        total_holds - holds_in_use
      end

      def hold_contents
        commodities.map { |commodity|
          [commodity, holds_for(commodity)]
        }.delete_if { |entry| entry[1].zero? }.push([:empty, empty_holds]).to_h
      end

      def have_quantity?(commodity, qty)
        holds_for(commodity) >= qty
      end

      def load(commodity, qty)
        return false unless total_holds > 0 && empty_holds > 0 && empty_holds > (total_holds-qty)
        increase_qty(commodity, qty)
      end

      def jettison(commodity, qty)
        return false unless have_quantity?(commodity, qty)
        decrease_qty(commodity, qty)
      end

    private

      def increase_qty(commodity, qty)
        update_attribute("#{commodity}_holds", holds_for(commodity) + qty)
      end

      def decrease_qty(commodity, qty)
        update_attribute("#{commodity}_holds", holds_for(commodity) - qty)
      end

      def holds_in_use
        commodities.map { |commodity|
          holds_for(commodity)
        }.inject(:+)
      end

      def valid_commodity?(commodity)
        commodities.include?(commodity)
      end

      def commodities
        %i[equipment ore organics colonist]
      end

      private

        def holds_for(commodity)
          attributes["#{commodity}_holds"]
        end

    end
  end
end
