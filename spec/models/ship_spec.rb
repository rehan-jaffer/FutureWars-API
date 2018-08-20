require 'rails_helper'

RSpec.describe Ship, type: :model do

  describe "hold info" do

    before :all do
      @player = FactoryBot.create(:player)
      @ship = @player.primary_ship
    end

    describe "Holds functionality" do

      before :each do
        @player = FactoryBot.create(:player)
        @ship = @player.primary_ship
      end

      describe "#available_holds" do

        it "returns the number of available holds" do
          expect(@ship.empty_holds).to eq 40
        end

        it "returns the number of available holds after loading products" do
          @ship.load(:equipment, 20)
          expect(@ship.empty_holds).to eq 20
        end

      end

      describe "#hold_contents" do

        it "returns the current contents of the holds (empty)" do
          expect(@ship.hold_contents).to eq({empty: 40})    
        end

        it "returns the current contents of the holds (single product)" do
          @ship.load(:equipment, 20)
          expect(@ship.hold_contents).to eq({empty: 20, equipment: 20})
        end

      end

      describe "#total_holds" do
     
        it "returns the total number of holds" do
          expect(@ship.total_holds).to eq 40
        end

      end

    end

    describe "capabilities" do

    before :all do
      @player = FactoryBot.create(:player)
      @ship = @player.primary_ship
    end

      describe "Genesis torpedoes" do

        it "should respond to genesis_torpedoes?" do
          expect(@ship).to respond_to(:genesis_torpedoes?)
          expect(@ship.genesis_torpedoes).to eq 0
        end

      end

      describe "Mines" do

      end

      describe "Long-range scanner" do
        it "can be checked" do
          expect(@ship).to respond_to(:long_range_scanner?)
        end
      end

      describe "Planet scanner" do
        it "can be checked" do
          expect(@ship).to respond_to(:planet_scanner?)
        end
      end

      describe "Transwarp-drive" do
        it "can be checked" do
          expect(@ship).to respond_to(:transwarp_drive?)
        end
      end

      describe "Photon Missiles" do
        it "can be checked" do
          expect(@ship).to respond_to(:photon_missiles?)
        end
      end

    end

  end

end
