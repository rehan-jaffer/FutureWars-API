class AddExtraFieldsToShipTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :ship_types, :min_holds, :integer, unsigned: true, default: 0
    add_column :ship_types, :max_shields, :integer, unsigned: true, default: 0
  end
end
