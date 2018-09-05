require 'rails_helper'
require './lib/sector/sector_events'

describe SectorEvents do

 describe "#has_events?" do

    before :all do
      @sector = FactoryBot.create(:sector, id: 20)
      @player = FactoryBot.create(:player)
    end

    describe "for probe" do

      context "when there's fighters in the sector" do

        before :all do
          @sector = FactoryBot.create(:sector, id: 200, fighters_deployed: 100, fighters_player_id: 1001, fighters_mode: "offensive")
          @sector_events = SectorEvents.new(@sector, @player)
        end

        it "returns true" do
          expect(@sector_events.has_events?(:probe)).to eq true
        end

      end

      context "when there aren't fighters in this sector" do

        before :all do
          @sector = FactoryBot.create(:sector, id: 30)
          @sector_events = SectorEvents.new(@sector, @player)
        end

        it "returns false" do
          expect(@sector_events.has_events?(:probe)).to eq false
        end

      end

    end

  end

end
