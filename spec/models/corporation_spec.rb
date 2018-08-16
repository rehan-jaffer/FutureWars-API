require 'rails_helper'

RSpec.describe Corporation, type: :model do

  it { should validate_presence_of(:name) }

  describe "#members" do

    before :all do
      @corporation = FactoryBot.create(:corporation)
      @p1 = FactoryBot.create(:player, corporation_id: @corporation.id)
      @p2 = FactoryBot.create(:player, corporation_id: @corporation.id)
      @p3 = FactoryBot.create(:player, corporation_id: @corporation.id)
    end

    after :all do
      @corporation.destroy
      @p1.destroy && @p2.destroy && @p3.destroy
    end

    it "should return the members of the corporation" do
      expect(@corporation.members.map(&:id)).to eq [@p1.id, @p2.id, @p3.id]
    end

  end

  describe "with_ceo" do

    before :all do
      @player = FactoryBot.create(:player)
      @corporation = FactoryBot.create(:corporation)
      @corporation.ceo_id = @player.id
      @corporation.save
    end

    it "should return corporations where the given player is CEO" do

      expect(Corporation.with_ceo(@player.id).first).to eq @corporation
  
    end

   end

end
