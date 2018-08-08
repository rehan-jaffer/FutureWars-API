module ClassZeroItems
  module Pricing
    def self.d
      DateTime.now.yday
    end
    def self.a(x)
     Math.sin(x)
    end

    def self.b(x)
      a(x) * 40
    end

    def self.fighter_price
      (b(d) + 200).round
    end

    def self.shield_price
     ((-1*b(d)) + 150).round
    end
  end
end

module Holds

  def self.price(number_holds)
    (base_cost * number_holds) + (increment * number_holds) * (number_holds - 1) / 2
  end

  def self.increment
    20
  end

  def self.base_cost
   (DateTime.now.yday % 99) + 151
  end
end
