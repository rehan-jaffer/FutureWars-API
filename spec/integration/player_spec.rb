require 'rails_helper'

describe 'Player API' do
  before :all do
    CreatePlayerService.call('ray', 'testpassword', 'ship name')
    CreatePlayerService.call('ray2', 'testpassword', 'ship name 2')
    Universe.create(10)
    @auth = authenticate_user('ray2', 'testpassword')
  end

  describe 'Visibility of other players' do
    it 'shows another player that is in my sector' do
      get '/api/sector/current', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      sector = JSON.parse(response.body)
      expect(sector).to have_key('players')
      expect(sector['players'].size).to eq 2
    end
  end
end
