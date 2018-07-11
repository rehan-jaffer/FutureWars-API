class CleaningUpDatabaseCruft < ActiveRecord::Migration[5.1]
  def change
    remove_column :sectors, :planet_type_id
    remove_column :sectors, :planet_name
    remove_column :sectors, :colonists
    remove_column :sectors, :ore
    remove_column :sectors, :equipment
    remove_column :sectors, :has_port
    remove_column :sectors, :equipment_qty
    remove_column :sectors, :ore_qty
    remove_column :sectors, :organics_qty
    remove_column :sectors, :port_class
    remove_column :sectors, :port_name
    drop_table :port_types
  end
end
