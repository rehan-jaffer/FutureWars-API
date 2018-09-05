require 'rails_helper'
require 'support/universe'
require 'pp'

RSpec.describe Sector, type: :model do

  after :each do
    Sector.destroy_all
    Player.destroy_all
  end

  describe "#has_enemy_fighters?" do

    before do
      @sector_with_fighters = FactoryBot.create(:sector, id: 400, fighters_deployed: 100, fighters_player_id: 1001)
      @sector_with_no_fighters = FactoryBot.create(:sector, id: 401)
      @player = FactoryBot.create(:player)
      @sector_with_own_fighters = FactoryBot.create(:sector, id: 402, fighters_deployed: 100, fighters_player_id: @player.id)
    end

    it "returns true for a sector containing enemy fighters" do
      expect(@sector_with_fighters.has_enemy_fighters?(@player.id)).to eq true    
    end

    it "returns false for a sector containing no fighters" do
      expect(@sector_with_no_fighters.has_enemy_fighters?(@player.id)).to eq false
    end

    it "returns false for a sector containing player's own fighters" do
      expect(@sector_with_own_fighters.has_enemy_fighters?(@player.id)).to eq false
    end

  end

  describe "#players_in_sector" do
  
    before do
      @sector = FactoryBot.create(:sector, id: 2001)
      @player_1 = FactoryBot.create(:player, current_sector: 2001)
      @player_2 = FactoryBot.create(:player, current_sector: 2001)
      @player_3 = FactoryBot.create(:player, current_sector: 2001)
      @player_4 = FactoryBot.create(:player, current_sector: 2002)
      @id_list = [@player_1, @player_2, @player_3].map(&:id)
    end

    it "returns the players currently in the sector" do
      expect(@sector.players_in_sector.pluck(:id)).to eq @id_list
    end

  end

  describe "#cloaked_ships_present" do

    before do
      @sector_with_uncloaked_player = FactoryBot.create(:sector, id: 3000)
      @uncloaked_player = FactoryBot.create(:player, current_sector: 3001)
      @sector_with_cloaked_player = FactoryBot.create(:sector, id: 3001)
      @cloaked_player = FactoryBot.create(:player_with_cloak, current_sector: 3001)
    end

    it "returns false with an uncloaked ship present" do
      expect(@sector_with_uncloaked_player.cloaked_ships_present?).to eq false
    end

    it "returns true with a cloaked ship present" do
      expect(@sector_with_cloaked_player.cloaked_ships_present?).to eq true
    end

  end

  describe "#limpet_mines_present" do

    before { @sector = FactoryBot.create(:sector, id: 3001) }

    it "always returns false" do
      expect(@sector.limpet_mines_present?).to eq false
    end

  end

end
