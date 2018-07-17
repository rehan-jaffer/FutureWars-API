class DefaultStrategy

  def self.initial_offer_price(offer_data)

  end

  def self.will_negotiate?(offer_data)
    (amount >= 20)
  end

  def self.will_accept?(offer_data)
    (amount == 20)
  end

  def self.counter_offer(offer_data)
    FIXED_PRICE + ((amount - FIXED_PRICE) / 2)
  end

end
