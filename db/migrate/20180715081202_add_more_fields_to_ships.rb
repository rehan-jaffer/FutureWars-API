class AddMoreFieldsToShips < ActiveRecord::Migration[5.1]
  def change
    add_column :ships, :name, :string
  end
end
