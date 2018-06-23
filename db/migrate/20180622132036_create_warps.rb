class CreateWarps < ActiveRecord::Migration[5.1]
  def change
    create_table :warps do |t|
      t.integer :origin_id
      t.integer :dest_id
    end
  end
end
