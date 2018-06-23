class RemovePasswordAttributeFromPlayers < ActiveRecord::Migration[5.1]
  def change
    remove_column :players, :password
  end
end
