class AddCorporationIdToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :corporation_id, :integer, unsigned: true
    add_index :players, :corporation_id
  end
end
