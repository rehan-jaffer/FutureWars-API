class AddInitialOfferToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :initial_offer, :integer
  end
end
