class AddFieldsToPlanetTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :planet_types, :colonists_fuel_ore_ratio, :integer, unsigned: false
    add_column :planet_types, :colonists_organics_ratio, :integer, unsigned: false
    add_column :planet_types, :colonists_equipment_ratio, :integer, unsigned: false
    add_column :planet_types, :colonists_fighters_ratio, :integer, unsigned: false
    add_column :planet_types, :max_colonists_fuel_ore, :integer, unsigned: false
    add_column :planet_types, :max_colonists_organics, :integer, unsigned: false
    add_column :planet_types, :max_colonists_equipment, :integer, unsigned: false
    add_column :planet_types, :max_product_fuel_ore, :integer, unsigned: false
    add_column :planet_types, :max_product_organics, :integer, unsigned: false
    add_column :planet_types, :max_product_equipment, :integer, unsigned: false
    add_column :planet_types, :max_product_fighters, :integer, unsigned: false
  end
end
