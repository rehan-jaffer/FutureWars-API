class AddOddsToShips < ActiveRecord::Migration[5.1]
  def change
    add_column :ship_types, :offensive_odds, :integer, unsigned: true
    add_column :ship_types, :defensive_odds, :integer, unsigned: true
  end
end
