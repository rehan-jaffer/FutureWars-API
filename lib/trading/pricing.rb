require 'date'

module Pricing

  module Fuel_Ore

    MCIC_COEFFICIENT = -0.193
    UNIT_NUMBER = 25.60558
    PERCENTAGE_NUMBER = 88.2752
    PERCENTAGE_NUMBER_2 = 88.2752

    def self.per_unit_price(max, trading_percent)
      ((max - UNIT_NUMBER) / PERCENTAGE_NUMBER) * (trading_percent - PERCENTAGE_NUMBER_2) + UNIT_NUMBER
    end

    def self.per_unit_price2(trading_percent, mcic)
      max = (MCIC_COEFFICIENT * mcic) + 26.4
      per_unit_price(max, trading_percent)
    end

  end

  module Holds

    INCREMENT = 20
    BASE_COST = (DateTime.now.yday % 99) + 151
  
    def self.price(number_holds)
      (BASE_COST * number_holds) + (INCREMENT * number_holds) * (number_holds - 1) / 2
    end

  end  
end
