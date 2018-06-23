class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :username, length: 25
      t.boolean :online, default: false
      t.integer :current_sector, unsigned: true
      t.integer :credits, default: 0, unsigned: true
      t.integer :turns, default: 0, unsigned: true
      t.integer :fighters, default: 0, unsigned: true
      t.integer :exp, default: 0, unsigned: true
      t.integer :holds, default: 0, unsigned: true
      t.integer :organics, default: 0, unsigned: true
      t.integer :equipment, default: 0, unsigned: true
      t.integer :colonists, default: 0, unsigned: true
      t.string :ship_name
    end
  end
end
