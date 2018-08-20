module Mixins
  module Ship
    module Capabilities

      delegate :long_range_scanner?, :planet_scanner?, :transwarp_drive?, :photon_missiles?, to: :ship_type, prefix: false

      def genesis_torpedoes?
        true
      end

    end
  end
end
