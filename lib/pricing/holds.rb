module Holds
  INCREMENT = 20
  BASE_COST = (DateTime.now.yday % 99) + 151

  def self.price(number_holds)
    (BASE_COST * number_holds) + (INCREMENT * number_holds) * (number_holds - 1) / 2
  end
end
