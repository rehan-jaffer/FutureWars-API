class AddPrimaryFlagToShips < ActiveRecord::Migration[5.1]
  def change
    add_column :ships, :primary, :boolean, default: false
  end
end
