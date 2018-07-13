require './spec/support/auth'
require 'rails_helper'
require 'pp'

describe 'Port Trading Functionality' do
  before :all do
    p = CreatePlayerService.call('ray', 'testpassword', 'test ship').result
    p.current_sector = 2
    p.save

    #    Universe.create(10)
    #    PortCreatorService.call("trades": 'BBS', sector_id: Sector.first)
    #    PortCreatorService.call("trades": 'BBS', sector_id: Sector.second)
    @auth = authenticate_user('ray', 'testpassword')
  end

  describe 'Querying a Port for trading information' do
    it 'allows querying of a port' do
      get '/api/ports/query/2', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      port = JSON.parse(response.body)
      player = Player.find_by(username: 'ray')
      expect(port).to have_key('items')
      expect(port['items']).to have_key('ore')
      expect(port['items']).to have_key('equipment')
      expect(port['items']).to have_key('organics')
    end

    it "doesn't permit querying a sector I'm not in" do
      get '/api/ports/query/3', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      errors = JSON.parse(response.body)
      expect(errors).to have_key('errors')
    end

    it 'allows querying a Class 0 special port' do
      player = Player.find_by(username: 'ray')
      player.current_sector = 1
      player.save

      get '/api/ports/query/1', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      items = JSON.parse(response.body)
      expect(items['items']).to have_key('fighters')
      expect(items['items']).to have_key('shields')
      expect(items['items']).to have_key('holds')
    end
  end

  describe 'Trading with a port (opening a transaction)' do
    it 'permits trading with a port' do
      player = Player.find_by(username: 'ray')
      player.current_sector = 2
      player.save

      post '/api/ports/trade', params: { id: 2, qty: 1, commodity: 'equipment', buy_or_sell: 'buy' }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      pp JSON.parse(response.body)
    end
  end
end
