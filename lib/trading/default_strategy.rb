require './lib/trading/pricing'
require 'pp'

class DefaultStrategy

  def self.initial_offer_price(offer_data)
    port = Port.find(offer_data[:port_id])
    port.per_unit_price(offer_data[:commodity]) * offer_data[:qty].to_i
  end

  def self.will_negotiate?(offer_data)
    offer_data[:amount] < (offer_data[:initial_offer]) && offer_data[:amount] > (offer_data[:initial_offer] * 0.6)
  end

  def self.will_accept?(offer_data)
    (offer_data[:amount] < offer_data[:initial_offer]) && offer_data[:amount] > (offer_data[:initial_offer] * 0.9)
  end

  def self.counter_offer(offer_data)
    offer_data[:amount] - (offer_data[:amount] - initial_offer_price(offer_data)).abs
  end

  private

    def self.qty(offer_data)
     (offer_data.qty.to_i || offer_data[:qtys])
    end

end

