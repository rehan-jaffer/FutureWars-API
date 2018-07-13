class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.integer :transaction_id
      t.integer :amount, unsigned: true
      t.timestamps
    end
    add_index :offers, :transaction_id
  end
end
