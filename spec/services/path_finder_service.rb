require 'rails_helper'
require 'pp'

describe PathFinderService do

  before :all do
    @player = FactoryBot.create(:player)
    @player.update_sector(1)
  end

  after :all do
    Player.destroy_all
  end

  describe "plotting a path between sector 1 and 10" do

    let(:path) { PathFinderService.call(@player.id, 10).result }

    it "contains the path" do
      expect(path[:path]).to eq [1,10]
    end

    it "contains the correct number of nodes" do
      expect(path[:nodes]).to eq 2
    end

    it "correctly designates the amount of turns required (in default merchant cruiser)" do
      expect(path[:cost]).to eq 3
    end

  end

  describe "plotting a path between sector 1 and 14 (in tunnel)" do

    let(:path) { PathFinderService.call(@player.id, 14).result }

    it "contains the path" do
      expect(path[:path]).to eq [1,10,11,12,13,14]
    end

    it "contains the correct number of nodes" do
      expect(path[:nodes]).to eq 6
    end

    it "correctly designates the amount of turns required (in default merchant cruiser)" do
      expect(path[:cost]).to eq 18
    end

  end

  describe "plotting a path between sector 1 and 14 (in tunnel)" do

    let(:path) { PathFinderService.call(@player.id, 15).errors }

    it "returns an error" do
      expect(path[:errors]).to include("No path exists between these sectors")
    end

  end

  describe "plotting a path between sector 1 and 65535 (non-existent)" do

    let(:path) { PathFinderService.call(@player.id, 65535).errors }
   
    it "returns an error" do
      expect(path[:errors]).to include("Destination does not exist!")
    end

  end

  describe "plotting a path when the player has no turns" do

    before :all do
      @player.turns = 0
      @player.save
    end

    let(:path) { PathFinderService.call(@player.id, 10).result }
   
    it "returns an error" do
      expect(path[:can_warp]).to eq false
    end

  end

end
