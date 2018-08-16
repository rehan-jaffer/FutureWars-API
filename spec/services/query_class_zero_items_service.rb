require 'rails_helper'

describe QueryClassZeroItemsService do

  describe "Querying a Class Zero Port" do

  before :each do
    @player = FactoryBot.create(:player)
    @player.update_sector(1)
  end

    describe "Player can query a class zero port and get item prices" do

      let (:class_zero_query) { QueryClassZeroItemsService.call(@player.id, 1).result }

      it "succeeds" do
        expect(class_zero_query).to have_key(:items)
      end

    end

    describe "Player cannot query a class zero port when not in the same sector" do

      let (:class_zero_query) { QueryClassZeroItemsService.call(@player.id, 1).errors }

      it "succeeds" do
        @player.update_sector(2)
        expect(class_zero_query[:errors]).to include("You are not in the same sector as this port")
      end

    end

  end

end
