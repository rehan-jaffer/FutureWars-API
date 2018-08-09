class CleanUpTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :players, :equipment
    remove_column :players, :organics
    remove_column :players, :fighters
    remove_column :players, :holds
    remove_column :players, :colonists
    remove_column :players, :ship_type_id
  end
end
