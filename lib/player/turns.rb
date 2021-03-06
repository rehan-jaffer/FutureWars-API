module PlayerUnit
  module Turns
    def move_cost(jumps)
      jumps * primary_ship.ship_type.turns_per_warp
    end

    def decrease_turns(n)
      update_attribute(:turns, (turns - n))
    end
  end
end
