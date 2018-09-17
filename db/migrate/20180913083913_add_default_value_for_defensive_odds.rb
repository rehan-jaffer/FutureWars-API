class AddDefaultValueForDefensiveOdds < ActiveRecord::Migration[5.1]
  def change
    change_column_default :ship_types, :defensive_odds, default: 1
  end
end
