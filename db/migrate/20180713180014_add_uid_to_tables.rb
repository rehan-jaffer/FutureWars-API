class AddUidToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :uid, :string, :length => 80
    add_column :offers, :uid, :string, :length => 80
  end
end
