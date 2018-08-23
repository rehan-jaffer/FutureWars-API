require 'rails_helper'

RSpec.describe Planet, type: :model do

  before :each do
    @sector = FactoryBot.create(:sector, id: 20)
    @planet = FactoryBot.create(:planet, sector_id: @sector.id)
  end

  describe "#colonists" do

    describe "accessing colonist data" do

      it "returns unassigned colonists" do 
        expect(@planet.unassigned_colonists).to eq 0
      end

      it "returns colonists assigned to ore" do
        expect(@planet.ore_colonists).to eq 0
      end

      it "returns colonists assigned to ore" do
        expect(@planet.organics_colonists).to eq 0
      end

      it "returns colonists assigned to ore" do
        expect(@planet.equipment_colonists).to eq 0
      end

    end
 
    describe "assigning colonists" do

      before :each do
        @planet.unassigned_colonists = 20
        @planet.save
      end

      it "allows assigning colonists to ore" do
        @planet.assign_colonists(:ore, 10)
        expect(@planet.ore_colonists).to eq 10
        expect(@planet.unassigned_colonists).to eq 10
      end

      it "allows assigning colonists to organics" do
        @planet.assign_colonists(:organics, 10)
        expect(@planet.organics_colonists).to eq 10
        expect(@planet.unassigned_colonists).to eq 10
      end

      it "allows assigning colonists to equipment" do
        expect(@planet.assign_colonists(:equipment, 10)).to eq true
        expect(@planet.equipment_colonists).to eq 10
        expect(@planet.unassigned_colonists).to eq 10
      end

      it "forbids assigning colonists to a production category that doesn't exist" do
        expect(@planet.assign_colonists(:garbage, 10)).to eq false
      end

    end

  end

end
