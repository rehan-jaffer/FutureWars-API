class CreateCorporations < ActiveRecord::Migration[5.1]
  def change
    create_table :corporations do |t|
      t.string :name, null: false
      t.integer :ceo_id, null: false
      t.integer :creator_id, null: false
      t.timestamps
    end
  end
end
