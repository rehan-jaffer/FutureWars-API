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
    it 'creates a player' do
      expect do
        CreatePlayerService.call('testuser', 'testpassword', 'testship', email: "ray@test.com")
      end.to change { Player.count }
    end
  end
end
