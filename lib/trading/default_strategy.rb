class DefaultStrategy

  def self.initial_offer_price(offer_data)

  end

  def self.will_negotiate?(offer_data)
    (offer_data.amount >= 20)
  end

  def self.will_accept?(offer_data)
    (offer_data.amount == 20)
  end

  def self.counter_offer(offer_data)
    FIXED_PRICE + ((offer_data.amount - FIXED_PRICE) / 2)
  end

end
