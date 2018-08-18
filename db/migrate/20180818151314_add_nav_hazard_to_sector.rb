class AddNavHazardToSector < ActiveRecord::Migration[5.1]
  def change
    add_column :sectors, :nav_hazard, :integer, null: false, default: 0
  end
end
