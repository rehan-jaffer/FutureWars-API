class AddUniquenessConstraintToUsername < ActiveRecord::Migration[5.1]
  def change
    change_column :players, :username, :string, unique: true
  end
end
