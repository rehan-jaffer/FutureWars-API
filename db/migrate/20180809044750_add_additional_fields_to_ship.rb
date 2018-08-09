class AddAdditionalFieldsToShip < ActiveRecord::Migration[5.1]
  def change
    add_column :ships, :additional_holds, :integer, unsigned: true, default: 0
    add_column :ships, :fighters, :integer, unsigned: true, default: 0
    add_column :ships, :shields, :integer, unsigned: true, default: 0
  end
end
