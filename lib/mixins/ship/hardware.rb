module Mixins
  module Ship
    module Hardware

      def can_equip?(item)
        true
      end

      def has_equip?(item, qty=0)
        true
      end

      def equip?

      end

    end
  end
end

