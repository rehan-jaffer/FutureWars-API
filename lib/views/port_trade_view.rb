class PortTradeView
  def self.build_view(attributes)
    trade_hash = {}
    %w[ore organics equipment].each do |commodity|
      trade_hash[commodity] = {
        status: PortTradeCommodity.buys_or_sells(attributes['port_class'], commodity),
        quantity: attributes["#{commodity}_qty"],
        trading: ((attributes["#{commodity}_qty"] / (attributes["#{commodity}_productivity"]) * 10) * 100).to_s + '%'
      }
    end
    trade_hash
  end

  def self.render(attributes)
    {
      items: build_view(attributes)
    }
  end
end
