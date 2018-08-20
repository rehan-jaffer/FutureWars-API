class ChangeFuelOreToOreForPlanetTypes < ActiveRecord::Migration[5.1]
  def change
    rename_column :planet_types, :colonists_fuel_ore_ratio, :colonists_ore_ratio
    rename_column :planet_types, :max_colonists_fuel_ore, :max_colonists_fuel_ore
    rename_column :planet_types, :max_product_fuel_ore, :max_product_ore
  end
end
