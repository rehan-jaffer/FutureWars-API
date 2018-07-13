class DummyStrategy
  FIXED_PRICE = 20

  def self.initial_offer_price(*_args)
    FIXED_PRICE
  end

  def self.will_negotiate?(amount, *_args)
    (amount >= 20)
  end

  def self.will_accept?(amount, *_args)
    (amount == 20)
  end

  def self.counter_offer(amount, *_args)
    FIXED_PRICE + ((amount - FIXED_PRICE) / 2)
  end
end
