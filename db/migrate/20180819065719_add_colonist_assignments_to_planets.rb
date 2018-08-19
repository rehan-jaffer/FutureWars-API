class AddColonistAssignmentsToPlanets < ActiveRecord::Migration[5.1]
  def change
    add_column :planets, :ore_colonists, :integer, null: false, default: 0
    add_column :planets, :organics_colonists, :integer, null: false, default: 0
    add_column :planets, :equipment_colonists, :integer, null: false, default: 0
    add_column :planets, :unassigned_colonists, :integer, null: false, default: 0
  end
end
