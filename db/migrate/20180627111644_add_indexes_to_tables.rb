class AddIndexesToTables < ActiveRecord::Migration[5.1]
  def change
    add_index :sectors, :id
    add_index :planet_types, :id
    add_index :ship_types, :id
    add_index :warps, :origin_id
    add_index :warps, :dest_id
  end
end
