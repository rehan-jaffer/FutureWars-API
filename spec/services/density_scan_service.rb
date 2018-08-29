require 'rails_helper'

describe DensityScanService do

  before :all do
    @player = FactoryBot.create(:player)
  end

  describe "density scanning of the sector the player is in" do
  
    let(:density_scan) { DensityScanService.call(@player, 1).result }

    it "succeeds" do
      expect(density_scan).to be_a_kind_of Array
      expect(density_scan.map { |s| s[:density] }).to all be_a_kind_of Integer
    end

  end

  describe "density scanning of a sector that the player is not in" do

    let(:density_scan) { DensityScanService.call(@player, 2).errors }

    it "fails" do
      expect(density_scan[:errors]).to include("You are not in that sector")
    end

  end

end
