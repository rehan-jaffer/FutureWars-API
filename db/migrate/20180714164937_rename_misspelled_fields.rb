class RenameMisspelledFields < ActiveRecord::Migration[5.1]
  def change
    if column_exists? :ports, :organics_productivitiy
      rename_column :ports, :organics_productivitiy, :organics_productivity
    end
  end
end
