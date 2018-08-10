require 'rails_helper'
require './spec/support/auth'

describe 'Player API' do
  before :all do
    p1 = FactoryBot.create(:player)
    p2 = FactoryBot.create(:player, password: "testpassword")
    @auth = authenticate_user('ray2', 'testpassword')
    puts p1.username
    puts p2.username
  end

  after :all do
    Player.destroy_all
  end

  describe 'Player#stat' do
    context 'player is authorized' do
      it "returns the user's stats" do
        get '/api/player/stats', headers: { 'AUTHORIZATION': @auth['auth_token'] }
        player = JSON.parse(response.body)
        pp player
        expect(player).to have_key('username')
      end
    end

    context 'player is not authorized' do
      it 'returns an error' do
        get '/api/player/stats'
        error = JSON.parse(response.body)
        expect(error['error']).to eq 'Not Authorized'
      end
    end
  end

  describe 'Visibility of other players' do
    it 'shows another player that is in my sector' do
      get '/api/nav/sector/current', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      sector = JSON.parse(response.body)
      expect(sector).to have_key('players')
      expect(sector['players'].size).to eq 2
    end
  end
end
