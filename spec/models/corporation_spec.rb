require 'rails_helper'

RSpec.describe Corporation, type: :model do

  it { should validate_presence_of(:name) }

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
