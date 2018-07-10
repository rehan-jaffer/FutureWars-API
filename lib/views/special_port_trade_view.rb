class SpecialPortTradeView
  def self.build_view(attributes)
    trade_hash = {}
    %w[holds shields fighters].each do |commodity|
      trade_hash[commodity] = {
        status: "Selling",
        available: 100
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
