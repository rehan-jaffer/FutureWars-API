class AddFieldsToShipTypes < ActiveRecord::Migration[5.1]
  def change
    remove_column :ship_types, :initial_holds
    add_column :ship_types, :base_holds, :integer, unsigned: true
    add_column :ship_types, :max_fighters, :integer, unsigned: true
    add_column :ship_types, :max_fighters_per_attack, :integer, unsigned: true
    add_column :ship_types, :long_range_scan, :boolean, default: false
  end
end
