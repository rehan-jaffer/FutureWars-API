class AddExtraFieldsToShips < ActiveRecord::Migration[5.1]
  def change
    add_column :ships, :genesis_torpedoes, :integer, unsigned: true, default: 0
    add_column :ships, :ether_probes, :integer, unsigned: true, default: 0
    add_column :ships, :limpet_mines, :integer, unsigned: true, default: 0
    add_column :ships, :armid_mines, :integer, unsigned: true, default: 0
  end
end
