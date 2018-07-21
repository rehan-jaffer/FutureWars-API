class AddExtraFieldsToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :commodity, :string
    add_column :transactions, :qty, :string
  end
end
