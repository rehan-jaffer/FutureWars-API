class AddTradeTypeToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :trade_type, :string
  end
end
