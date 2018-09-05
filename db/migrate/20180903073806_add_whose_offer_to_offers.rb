class AddWhoseOfferToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :actor_type, :string, default: "port"
  end
end
