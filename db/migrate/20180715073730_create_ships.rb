class CreateShips < ActiveRecord::Migration[5.1]
  def change
    create_table :ships do |t|
      t.integer :player_id
      t.integer :ship_type_id
      t.string :banner, length: 32
      t.string :serial, length: 32
      t.integer :total_holds, unsigned: true
      t.integer :empty_holds, unsigned: true
      t.integer :shield_points, unsigned: true
      t.timestamps
    end
    add_index :ships, :player_id
    add_index :ships, :ship_type_id
  end
end
