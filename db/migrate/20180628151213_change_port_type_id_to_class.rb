class ChangePortTypeIdToClass < ActiveRecord::Migration[5.1]
  def change
    remove_column :sectors, :port_type_id
    add_column :sectors, :port_class, :integer
  end
end
