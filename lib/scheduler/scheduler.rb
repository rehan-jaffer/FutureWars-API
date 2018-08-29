module Scheduler
  module Planets
    def self.update_products
      Planet.all.each { |planet| planet.update_planet_products }
    end
  end
  module Ports
    def self.update_quantities
    end
  end

  module Players
    def self.update_turns
      turns = (Rails.configuration.game['turns_per_day'] / 24)
      turns_per_day = Rails.configuration.game['turns_per_day']
      Player.update_all(["turns = case
                                    when turns + ? >= ? then
                                      300
                                    when turns + ? < ? then
                                      turns + ?
                                    end", turns, turns_per_day, turns, turns_per_day, turns])
    end
  end
end
