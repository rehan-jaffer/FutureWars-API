class AddPortName < ActiveRecord::Migration[5.1]
  def change
    add_column :sectors, :port_name, :string
  end
end
