class AddDefaultsToPlanetTypeFields < ActiveRecord::Migration[5.1]
  def change
    change_column_null :planet_types, :colonists_fuel_ore_ratio, 0
    change_column_null :planet_types, :colonists_organics_ratio, 0
    change_column_null :planet_types, :colonists_equipment_ratio, 0
    change_column_null :planet_types, :max_colonists_fuel_ore, 0
    change_column_null :planet_types, :max_colonists_organics, 0
    change_column_null :planet_types, :max_colonists_equipment, 0
    change_column_null :planet_types, :max_product_fuel_ore, 0
    change_column_null :planet_types, :max_product_organics, 0
    change_column_null :planet_types, :max_product_equipment, 0
    change_column_null :planet_types, :max_product_fighters, 0
  end
end
