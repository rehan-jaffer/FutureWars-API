require 'rails_helper'

describe JoinCorporationService do

  before :all do
    @player = FactoryBot.create(:player)
    @corp_creator = FactoryBot.create(:player)
    @corporation = FactoryBot.create(:corporation, ceo_id: @corp_creator.id, creator_id: @corp_creator.id) 
  end

  describe "Player joining a corporation" do

    let(:join_corporation) { JoinCorporationService.call(@player.id, @corporation.id).result }

    it "succeeds" do
      expect(join_corporation).to eq @corporation
    end

  end

  describe "Player joining a corporation while already being in one" do

    before :all do
      @player.corporation_id = @corporation.id
      @player.save
    end

    let(:join_corporation) { JoinCorporationService.call(@player.id, @corporation.id).errors }

    it "fails" do
      expect(join_corporation[:errors]).to include("You are already in a corporation, leave first")
    end

  end

  describe "Player joining a corporation that doesn't exist" do

    let(:join_corporation) { JoinCorporationService.call(@player.id, 999).errors }

    it "fails" do
      expect(join_corporation[:errors]).to include("Corporation does not exist")
    end

  end


end
