class AddAdditionalShipTypeFields < ActiveRecord::Migration[5.1]
  def change
    add_column :ship_types, :mine_max, :integer, unsigned: false
    add_column :ship_types, :genesis_max, :integer, unsigned: false
    add_column :ship_types, :beacon_max, :integer, unsigned: false
    add_column :ship_types, :long_range_scanner, :boolean, default: false
    add_column :ship_types, :planet_scanner, :boolean, default: false
    add_column :ship_types, :transwarp_drive, :boolean, default: false
    add_column :ship_types, :photon_missiles, :boolean, default: false
    add_column :ship_types, :max_transporter_range, :integer, default: 0
  end
end
