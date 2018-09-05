class AddDefaultValueForAccumulatedTradingCredits < ActiveRecord::Migration[5.1]
  def change
    change_column :ports, :accumulated_trading_credits, :integer, unsigned: true, default: 0
  end
end
