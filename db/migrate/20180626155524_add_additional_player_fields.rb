class AddAdditionalPlayerFields < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :alignment, :integer
    add_column :players, :ship_type_id, :integer, unsigned: true
  end
end
