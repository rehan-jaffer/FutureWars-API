class AddShipFields < ActiveRecord::Migration[5.1]
  def change
    add_column :ship_types, :max_holds, :integer, unsigned: true
    add_column :ship_types, :initial_holds, :integer, unsigned: true
    add_column :ship_types, :cost, :integer, unsigned: true
    add_column :ship_types, :turns_per_warp, :integer, unsigned: true
  end
end
