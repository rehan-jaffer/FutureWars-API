require 'rails_helper'

RSpec.describe Ship, type: :model do

  describe "hold info" do

    before :all do
      @player = FactoryBot.create(:player)
      @ship = @player.primary_ship
    end

    describe "#total_holds" do
     
      it "returns the total number of holds" do
        expect(@ship.total_holds).to eq 40
      end

    end

  end

end
