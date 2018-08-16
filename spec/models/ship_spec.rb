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

    describe "#available_holds" do

      it "returns the number of available holds" do
        expect(@ship.empty_holds).to eq 40
      end

      it "returns the number of available holds after loading products" do
        @ship.load_hold(:equipment, 20)
        expect(@ship.empty_holds).to eq 20
      end

    end

  end

end
