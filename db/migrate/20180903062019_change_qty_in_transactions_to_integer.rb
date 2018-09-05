class ChangeQtyInTransactionsToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :qty, :integer, unsigned: true
  end
end
