class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :from_id, null: false
      t.integer :to_id, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
