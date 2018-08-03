class CreatePlanets < ActiveRecord::Migration[5.1]
  def change
    create_table :planets do |t|
      t.string :name
      t.integer :planet_type_id, unsigned: false
      t.integer :owner_id, unsigned: false
      t.integer :creator_id, unsigned: false
      
    end
  end
end
