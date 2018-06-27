class UpdatePortsSchema < ActiveRecord::Migration[5.1]
  def change
    remove_column :sectors, :trades_equipment
    remove_column :sectors, :trades_organics
    remove_column :sectors, :trades_ore
    add_column :sectors, :port_type_id, :integer
    add_index :sectors, :port_type_id
  end
end
