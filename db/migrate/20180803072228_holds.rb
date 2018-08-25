class Holds < ActiveRecord::Migration[5.1]
  def change
    create_table :holds do |t|
      t.integer :ship_id, null: false, unsigned: true
      t.integer :qty, null: false, unsigned: true
      t.string :contents, null: false
    end
    add_index :holds, :ship_id
  end
end
