class AddFightersToSectors < ActiveRecord::Migration[5.1]
  def change
    add_column :sectors, :fighters_deployed, :integer, unsigned: true, default: 0
    add_column :sectors, :fighters_player_id, :integer, unsigned: true
    add_column :sectors, :fighters_mode, :string, default: "defensive", null: false
  end
end
