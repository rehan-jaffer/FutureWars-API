class AddShipCostFieldsToShips < ActiveRecord::Migration[5.1]
  def change
    add_column :ship_types, :basic_hold_cost, :integer, unsigned: true
    add_column :ship_types, :main_drive_cost, :integer, unsigned: true
    add_column :ship_types, :computer_cost, :integer, unsigned: true
    add_column :ship_types, :ship_hull_cost, :integer, unsigned: true
    add_column :ship_types, :ship_base_cost, :integer, unsigned: true
  end
end
