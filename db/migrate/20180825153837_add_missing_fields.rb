class AddMissingFields < ActiveRecord::Migration[5.1]
  def change
    add_index :planets, :planet_type_id
    add_index :planets, :owner_id
    add_index :planets, :creator_id
    add_index :planets, :sector_id
    add_index :messages, :from_id
    add_index :messages, :to_id
    change_column :planet_types, :max_product_fighters, :integer, unsigned: false, default: 0
    change_column :ports, :ore_qty, :integer, unsigned: false, default: 0
    change_column :ports, :organics_qty, :integer, unsigned: false, default: 0
    change_column :ports, :equipment_qty, :integer, unsigned: false, default: 0
  end
end
