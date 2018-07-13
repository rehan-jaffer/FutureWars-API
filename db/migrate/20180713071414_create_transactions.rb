class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :port_id
      t.integer :player_id
      t.boolean :open, default: true
      t.string :status
      t.timestamps
    end
    add_index :transactions, :port_id
    add_index :transactions, :player_id
  end
end
