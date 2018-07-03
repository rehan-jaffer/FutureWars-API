class PortTradeView

  def self.build_view(attributes)
    trade_hash = {}
    ["ore","organics","equipment"].each do |commodity|
      trade_hash[commodity] = {
           status: PortTradeCommodity.buys_or_sells(attributes["port_class"], commodity),
           trading: attributes["#{commodity}_qty"],
           capacity: "100%"
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
