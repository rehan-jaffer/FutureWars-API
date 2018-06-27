class AddAdditionalSectorFields < ActiveRecord::Migration[5.1]
  def change
    add_column :sectors, :has_port, :boolean, default: false
    add_column :sectors, :trades_equipment, :string
    add_column :sectors, :trades_organics, :string
    add_column :sectors, :trades_ore, :string
    add_column :sectors, :equipment_qty, :integer, unsigned: true, default: 0
    add_column :sectors, :organics_qty, :integer, unsigned: true, default: 0
    add_column :sectors, :ore_qty, :integer, unsigned: true, default: 0
    add_column :sectors, :equipment_buy_price, :integer, unsigned: true, default: 0
    add_column :sectors, :organics_buy_price, :integer, unsigned: true, default: 0
    add_column :sectors, :ore_buy_price, :integer, unsigned: true, default: 0
    add_column :sectors, :equipment_sell_price, :integer, unsigned: true, default: 0
    add_column :sectors, :organics_sell_price, :integer, unsigned: true, default: 0
    add_column :sectors, :ore_sell_price, :integer, unsigned: true, default: 0
  end
end
