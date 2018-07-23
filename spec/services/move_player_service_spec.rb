require 'rails_helper'

describe MovePlayerService do

  describe "Moving a Player between connected sectors" do

    context "valid moves" do

      it "allows a player to move between services" do

        p = CreatePlayerService.call("myuser", "testpassword", "ship name").result
        dest = Sector.find(p.current_sector).warps.sample
        result = MovePlayerService.call(p.id, dest)
        expect(p.reload.current_sector).to eq dest

      end

   end

   context "invalid moves" do

     let(:p) { CreatePlayerService.call("myuser", "testpassword", "ship name").result  }

     it "does not permit move to non-neighbouring sector" do
        warps = Sector.find(p.current_sector).warps
        dest = (Sector.all.map(&:id) - warps).sample
        result = MovePlayerService.call(p.id, dest)
        expect(result.errors).to have_key(:errors)
     end

     it "does not permit travel when the player has no turns left" do
        p.turns = 0
        p.save
        dest = Sector.find(p.current_sector).warps.sample
        result = MovePlayerService.call(p.id, dest)
        expect(p.reload.current_sector).to eq 1
        expect(result.errors).to have_key(:errors)
     end

     it "does not permit travel to a part of space that doesn't exist" do
        result = MovePlayerService.call(p.id, 99999999)
        expect(p.reload.current_sector).to eq 1
        expect(result.errors).to have_key(:errors)
     end

   end

  end


end
