class ChangeLengthOfDescriptionField < ActiveRecord::Migration[5.1]
  def change
    change_column :ship_types, :description, :text
  end
end
