require './lib/trading/pricing'
require 'pp'

class DefaultStrategy

  def self.initial_offer_price(offer_data)
    commodity = (offer_data.transaction) ? offer_data.transaction["commodity"] : offer_data.commodity
    mcic = offer_data.port["#{commodity}_mcic"]
    trading_percent = offer_data.port["#{commodity}_trading"]
    Pricing::Fuel_Ore::per_unit_price2(mcic, trading_percent)*qty(offer_data)
  end

  def self.will_negotiate?(offer_data)
    offer_data.amount < (offer_data.transaction["initial_offer"]) && offer_data.amount > (offer_data.transaction["initial_offer"] * 0.6)
  end

  def self.will_accept?(offer_data)
    (offer_data.amount < offer_data.transaction["initial_offer"]) && offer_data.amount > (offer_data.transaction["initial_offer"] * 0.9)
  end

  def self.counter_offer(offer_data)
    offer_data.amount - (offer_data.amount - initial_offer_price(offer_data)).abs
  end

  private

    def self.qty(offer_data)
     (offer_data.qty.to_i || offer_data.transaction["qty"])
    end

end

