require 'rails_helper'

describe Warp do

  describe ".warps_for" do

    it "returns the correct warps for sector 1" do
      expect(Warp.warps_for(1)).to eq (2..10).to_a
    end

  end

  describe ".connect" do
  
    before :all do
      @s1 = FactoryBot.create(:sector, id: 31)
      @s2 = FactoryBot.create(:sector, id: 32)
    end

    it "connects two unconnected sectors" do
      Warp.connect(@s1.id, @s2.id)
      expect(@s1.warps).to include(@s2.id)
      expect(@s2.warps).to include(@s1.id)
    end

  end

end
