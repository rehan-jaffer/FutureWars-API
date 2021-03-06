require 'rails_helper'

describe MovePlayerService do
  describe 'Moving a Player between connected sectors' do
    context 'valid moves' do
      before :all do
        @p = FactoryBot.create(:player)
        @turns = @p.turns
        @dest = Warp.warps_for(@p.current_sector).sample
        @result = MovePlayerService.call(@p.id, @dest)
      end

      it "updates the player's position" do
        expect(@p.reload.current_sector).to eq @dest
      end

      it 'deducts the correct amount of turns from a player' do
        expect(@p.turns).to eq (@turns - @p.primary_ship.ship_type.turns_per_warp)
      end
    end

    context 'invalid moves' do
      let (:p) { FactoryBot.create(:player) }

      it 'does not permit move to non-neighbouring sector' do
        warps = Sector.find(p.current_sector).warps
        dest = (Sector.all.map(&:id) - warps).sample
        result = MovePlayerService.call(p.id, dest)
        expect(result.errors).to have_key(:errors)
      end

      it 'does not permit travel when the player has no turns left' do
        p.turns = 0
        p.save
        dest = Sector.find(p.current_sector).warps.sample
        result = MovePlayerService.call(p.id, dest)
        expect(p.reload.current_sector).to eq 1
        expect(result.errors).to have_key(:errors)
        expect(result.errors[:errors]).to include("You have no turns left")
      end

      it "does not permit travel to a part of space that doesn't exist" do
        result = MovePlayerService.call(p.id, 99_999_999)
        expect(p.reload.current_sector).to eq 1
        expect(result.errors).to have_key(:errors)
        expect(result.errors[:errors]).to include("Not a valid sector ID")
      end
    end
  end
end
