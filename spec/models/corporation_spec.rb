require 'rails_helper'

RSpec.describe Corporation, type: :model do

  it { should validate_presence_of(:name) }

  describe "#members" do

    before :all do
      @corporation = FactoryBot.create(:corporation)
      @player_1 = FactoryBot.create(:player, corporation_id: @corporation.id)
      @player_2 = FactoryBot.create(:player, corporation_id: @corporation.id)
      @player_3 = FactoryBot.create(:player, corporation_id: @corporation.id)
    end

    after :all do
      @corporation.destroy
      @player_1.destroy && @player_2.destroy && @player_3.destroy
    end

    it "should return the members of the corporation" do
      expect(@corporation.members.map(&:id)).to eq [@player_1.id, @player_2.id, @player_3.id]
    end

  end

  describe "stream_id" do
   
    it "provides its own stream ID" do
      @corporation = FactoryBot.create(:corporation)
      expect(@corporation.stream_id).to eq "corporation-#{@corporation.id}"
    end

  end

  describe "with_ceo" do

    before :all do
      @corporation = FactoryBot.create(:corporation)
      @player = FactoryBot.create(:player)
      @corporation.ceo_id = @player.id
      @corporation.save
    end

    it "should return corporations where the given player is CEO" do

      expect(Corporation.with_ceo(@player.id).first).to eq @corporation
  
    end

   end

end
