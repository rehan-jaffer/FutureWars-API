class AddFinalFlagToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :final, :boolean, default: false
  end
end
