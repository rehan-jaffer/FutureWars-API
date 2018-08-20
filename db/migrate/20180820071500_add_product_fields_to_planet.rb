class AddProductFieldsToPlanet < ActiveRecord::Migration[5.1]
  def change
    add_column :planets, :ore, :integer, unsigned: true, null: false
    add_column :planets, :organics, :integer, unsigned: true, null: false
    add_column :planets, :equipment, :integer, unsigned: true, null: false
  end
end
