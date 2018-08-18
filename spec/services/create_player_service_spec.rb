require 'rails_helper'

describe CreatePlayerService do
  describe 'Supplied fields' do
    context 'No Username Supplied' do
      it 'returns with an error' do
        result = CreatePlayerService.call(nil, 'testpassword', 'shipname', email: "ray@test.com")
        expect(result.errors).to have_key(:errors)
      end
    end

    context 'No Password Supplied' do
      it 'returns with an error' do
        result = CreatePlayerService.call('testuser', nil, 'shipname', email: "ray@test.com")
        expect(result.errors).to have_key(:errors)
      end
    end

    context 'No Ship Name Supplied' do
      it 'returns with an error' do
        result = CreatePlayerService.call('testuser', 'testpassword', nil, email: "ray@test.com")
        expect(result.errors).to have_key(:errors)
      end
    end
  end

  describe 'Creates a Player' do

    let(:valid_player) { CreatePlayerService.call('testuser', 'testpassword', 'testship', email: 'ray@thelondonvandal.com') }

    it 'changes the number of players' do
      expect do
        valid_player
      end.to change { Player.count }
    end

    it 'creates a user with a merchant cruiser as the default' do
      expect(valid_player.result.primary_ship).to be_a_kind_of Ship
      expect(valid_player.result.primary_ship.ship_type.name).to eq "Merchant Cruiser"
    end

    
  end
end
