class CreateSectors < ActiveRecord::Migration[5.1]
  def change
    create_table :sectors do |t|
      t.integer :planet_type_id
      t.string :planet_name
      t.integer :colonists, default: 0
      t.integer :ore, default: 0
      t.integer :equipment, default: 0
      t.integer :fighters, default: 0
      t.integer :organics, default: 0
      t.integer :owned_by
      t.timestamps
    end
    add_index :sectors, :planet_type_id
  end
end
