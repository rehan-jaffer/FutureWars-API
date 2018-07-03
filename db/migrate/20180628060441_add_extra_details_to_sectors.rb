class AddExtraDetailsToSectors < ActiveRecord::Migration[5.1]
  def change
    add_column :sectors, :home_sector, :boolean, default: false
    add_column :sectors, :federation_space, :boolean, default: false
  end
end
