class AddDefaultsToPlanetProductQuantities < ActiveRecord::Migration[5.1]
  def change
    change_column :planets, :ore, :integer, null: false, default: 0
    change_column :planets, :organics, :integer, null: false, default: 0
    change_column :planets, :equipment, :integer, null: false, default: 0
  end
end
