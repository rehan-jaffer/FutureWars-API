class AddMoonsToPlanets < ActiveRecord::Migration[5.1]
  def change
    create_table :moons do |t|
      t.string :name, null: false
      t.integer :planet_id, null: false
    end
  
    add_index :moons, :planet_id
  end
end
