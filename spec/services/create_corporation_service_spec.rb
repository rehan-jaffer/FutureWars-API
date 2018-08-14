require 'rails_helper'

describe CreateCorporationService do

  before :all do
    @player = FactoryBot.create(:player)
  end

  describe "Player creating a corporation" do

    let(:corp) { CreateCorporationService.call(@player.id, "Corporation Name").result }

    it "succeeds" do
      expect(corp.name).to eq "Corporation Name"
    end

  end

  describe "Player creating a corporation despite already being in one" do

    before :all do
      @corp = FactoryBot.create(:corporation, name: "ACME Corp")
      @player.corporation_id = @corp.id
      @player.save
    end

    after :all do
      Corporation.where(name: 'ACME Corp').destroy_all
    end

    let(:corp) { CreateCorporationService.call(@player.id, "Corporation Name").errors }

    it "fails" do
      expect(corp[:errors]).to include("You are already in a corporation")
    end

  end

  describe "Player creating a corporation with a name already taken" do

    before :all do
      @corp = FactoryBot.create(:corporation, name: "ACME Corp")
    end

    let(:corp) { CreateCorporationService.call(@player.id, "ACME Corp").errors }

    it "fails" do
      expect(corp[:errors]).to include("Corporation already exists with that name")
    end

  end

end
