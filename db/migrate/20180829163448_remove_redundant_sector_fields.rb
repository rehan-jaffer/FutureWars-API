class RemoveRedundantSectorFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :sectors, :fighters
    remove_column :sectors, :organics
    remove_column :sectors, :home_sector
  end
end
