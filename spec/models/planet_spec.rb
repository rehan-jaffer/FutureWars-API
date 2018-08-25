require 'rails_helper'

RSpec.describe Planet, type: :model do

  before :each do
    @sector = FactoryBot.create(:sector, id: 20)
    @planet = FactoryBot.create(:planet, sector_id: @sector.id)
  end

  describe "#moons" do

   it "should respond to a request for moons" do
     expect { @planet.moons }.not_to raise_error
   end

   it "should have a random number of moons" do
     expect(@planet.moons.size).to be > 0
   end

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

    describe "reassigning colonists" do

      before :each do
        @planet.ore_colonists = 10
        @planet.organics_colonists = 10
        @planet.equipment_colonists = 10
        @planet
      end

      it "allows reassigning colonists from ore to organics (for instance)" do
        expect(@planet.reassign_colonists(:ore, :organics, 10)).to eq true
        expect(@planet.ore_colonists).to eq 0
        expect(@planet.organics_colonists).to eq 20
      end

    end

  end

end
