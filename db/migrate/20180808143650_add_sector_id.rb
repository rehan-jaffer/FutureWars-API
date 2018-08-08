class AddSectorId < ActiveRecord::Migration[5.1]
  def change
    add_column :planets, :sector_id, :integer
  end
end
