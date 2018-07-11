class CreatePorts < ActiveRecord::Migration[5.1]
  def change
    create_table :ports do |t|
      t.integer :port_class, null: false
      t.string :name, null: false
      t.integer :accumulated_trading_credits, unsigned: true, default: 0
      t.integer :sector_id, null: false
      t.integer :ore_productivity, unsigned: true, default: 0
      t.integer :organics_productivitiy, unsigned: true, default: 0
      t.integer :equipment_productivity, unsigned: true, default: 0
      t.integer :ore_mcic, default: 0
      t.integer :organics_mcic, default: 0
      t.integer :equipment_mcic, default: 0
      t.timestamps
    end

    add_index :ports, :sector_id

  end

end
