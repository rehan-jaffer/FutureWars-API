class AddCodesToTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :port_types, :port_code, :integer, unique: true
  end
end
