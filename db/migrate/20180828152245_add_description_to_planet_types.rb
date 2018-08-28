class AddDescriptionToPlanetTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :planet_types, :description, :text
  end
end
