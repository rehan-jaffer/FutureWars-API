class UpdatePortsFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :sectors, :equipment_buy_price
    remove_column :sectors, :equipment_sell_price
    remove_column :sectors, :ore_buy_price
    remove_column :sectors, :ore_sell_price
    remove_column :sectors, :organics_buy_price
    remove_column :sectors, :organics_sell_price
  end
end
