class AddAuthToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :email, :string
    add_column :players, :password, :string
    change_column :players, :username, :string, unique: true
  end
end
