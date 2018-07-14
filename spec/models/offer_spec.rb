require 'rails_helper'

RSpec.describe Offer, type: :model do

  before :all do
     @player = CreatePlayerService.call("ray", "testpassword", "USS Ship Name").result
     @transaction = Transaction.create(player_id: @player.id, port_id: Port.first.id, status: "open")
#    transaction = Transaction.create(
  end

  it "sets its own UID before saving" do

    @offer = Offer.create(transaction_id: @transaction.id, amount: 20)
    @offer.save
    expect(@offer.uid).to match /SCN00..[a-zA-Z0-9]+/

  end

end
