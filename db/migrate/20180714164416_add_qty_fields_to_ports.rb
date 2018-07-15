class AddQtyFieldsToPorts < ActiveRecord::Migration[5.1]
  def change
    add_column :ports, :ore_qty, :integer, unsigned: true
    add_column :ports, :equipment_qty, :integer, unsigned: true
    add_column :ports, :organics_qty, :integer, unsigned: true
  end
end
