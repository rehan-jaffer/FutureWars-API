class AddIndexToFightersPlayersId < ActiveRecord::Migration[5.1]
  def change
    add_index :sectors, :fighters_player_id
  end
end
