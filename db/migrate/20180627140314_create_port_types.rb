class CreatePortTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :port_types do |t|
      t.string :description
      t.timestamps
    end
  end
end
