require 'rails_helper'

describe LeaveCorporationService do

  describe "Player leaving a corporation they belong to" do

    before :all do
      @player = FactoryBot.create(:player)
      @corporation = FactoryBot.create(:corporation)
      @player.corporation_id = @corporation.id
      @player.save
    end

    let(:leave_corporation) { LeaveCorporationService.call(@player.id, @corporation.id).result }

    it "succeeds" do
      expect(leave_corporation).to eq @player
    end

  end

  describe "Player leaving a corporation they do not belong to" do

    before :all do
      @player = FactoryBot.create(:player)
      @corporation = FactoryBot.create(:corporation)
    end

    let(:leave_corporation) { LeaveCorporationService.call(@player.id, @corporation.id).errors }

    it "fails" do
      expect(leave_corporation[:errors]).to include("You are not in this corporation")
    end


  end

end
