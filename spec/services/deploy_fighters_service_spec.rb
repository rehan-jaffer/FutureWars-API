require 'rails_helper'

describe DeployFightersService do

  before :each do
    @player = FactoryBot.create(:player)
    ship = @player.primary_ship
    ship.fighters = 500
    ship.save
    @sector = Sector.find(1)
    @sector.fighters_deployed = 100
    @sector.save
  end

  describe "deploying fighters to a sector when the player has enough" do

    let(:deploy_fighters) { DeployFightersService.call(@player, 400).result }

    it "succeeds" do
      expect(deploy_fighters.fighters_deployed).to eq 500
    end    

  end

  describe "deploying fighters to a sector when the player does not have enough" do

    let(:deploy_fighters) { DeployFightersService.call(@player, 700).errors }

    it "succeeds" do
      expect(deploy_fighters[:errors]).to include("Not enough fighters")
    end    

  end

  describe "retrieving fighters from a sector when the sector has enough" do

    let(:deploy_fighters) { DeployFightersService.call(@player, -1).result }

    it "succeeds" do
      expect(deploy_fighters.fighters_deployed).to eq 99
    end    

  end

  describe "retrieving fighters from a sector when the sector does not have enough" do

    let(:deploy_fighters) { DeployFightersService.call(@player, -700).errors }

    it "succeeds" do
      expect(deploy_fighters[:errors]).to include("Fighters not deployed here")
    end    

  end

end
