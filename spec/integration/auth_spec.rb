require 'rails_helper'

describe 'Authentication API' do
  context 'User Login' do
    before :all do
      FactoryBot.create(:player, username: 'testuser', password: 'password')
    end

    after :all do
      Player.delete_all
    end

    it 'allows login (correct password path)' do
      post '/api/auth', params: { username: 'testuser', password: 'password' }
      expect(response.status).to eq 200
    end

    it 'allows login (incorrect password path)' do
      post '/api/auth', params: { username: 'testuser', password: 'testpasswordwrong' }
      expect(response.status).to eq 401
    end

    it 'returns a JSON web token on successful login' do
      post '/api/auth', params: { username: 'testuser', password: 'password' }
      json = JSON.parse(response.body)
      expect(json['auth_token']).not_to be nil
    end
  end

  context 'User Information' do
    before :all do
      FactoryBot.create(:player, username: 'testuser', password: 'password')
      post '/api/auth', params: { username: 'testuser', password: 'password' }
      json = JSON.parse(response.body)
      @token = json['auth_token']
      @headers = { "Authorization": @token }
    end

    describe 'Stats' do
      before :all do
        get '/api/player/stats', headers: @headers
      end

      it 'allows me to access my current stats' do
        expect(response.status).to eq 200
      end

      it 'shows me the correct information' do
        expect(response.body).not_to be nil
      end
    end
  end
end
