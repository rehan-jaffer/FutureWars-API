class AddHoldFieldsToShip < ActiveRecord::Migration[5.1]
  def change
    add_column :ships, :ore_holds, :integer, null: false, default: 0
    add_column :ships, :organics_holds, :integer, null: false, default: 0
    add_column :ships, :equipment_holds, :integer, null: false, default: 0
    add_column :ships, :colonist_holds, :integer, null: false, default: 0
  end
end
