require './lib/trading/default_strategy'
require './spec/support/auth'
require 'rails_helper'
require 'pp'

describe 'Port Trading Functionality' do
  before :all do
    @p = FactoryBot.create(:player)
    sector = FactoryBot.create(:sector, id: 10099)
    port = FactoryBot.create(:special_port, sector_id: 10099)
    @auth = authenticate_user(@p.username, 'testpassword')
  end

  after :all do
    Player.destroy_all
  end

  describe 'Querying a Port for trading information' do
    it 'allows querying of a port' do
      @p.update_sector(2)
      get '/api/subspace/ports/query/2', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      port = JSON.parse(response.body)
      expect(port).to have_key('items')
      expect(port['items']).to have_key('ore')
      expect(port['items']).to have_key('equipment')
      expect(port['items']).to have_key('organics')
    end

    it "doesn't permit querying a sector I'm not in" do
      get '/api/subspace/ports/query/3', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      errors = JSON.parse(response.body)
      expect(errors).to have_key('errors')
    end

    it 'allows querying a Class 0 special port' do
      player = Player.last
      player.current_sector = 10099
      player.save

      get '/api/subspace/ports/query/10099', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      items = JSON.parse(response.body)
      expect(items['items']).to have_key('fighters')
      expect(items['items']).to have_key('shields')
      expect(items['items']).to have_key('holds')
    end
  end

  describe 'Trading with a port (opening a transaction)' do
    before :all do
      @p.update_sector(3)
    end

    it 'permits trading with a port and opening a transaction (dummy strategy)' do
      Rails.configuration.trading_strategy = DummyStrategy
      post '/api/subspace/ports/trade', params: { id: 3, qty: 1, commodity: 'ore', trade_type: 'buy' }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('initial_offer')
    end

    it 'permits trading with a port and opening a transaction (default strategy)' do
      Rails.configuration.trading_strategy = DefaultStrategy
      post '/api/subspace/ports/trade', params: { id: 3, qty: 10, commodity: 'ore', trade_type: 'buy' }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
     transaction = JSON.parse(response.body)
     expect(transaction).to have_key('transaction')
      expect(transaction).to have_key('initial_offer')
    end
  end

  describe 'Transaction handling (Dummy Trading Strategy)' do
    before :all do
      @p.update_sector(2)

      @transaction = Transaction.create(player_id: @p.id, port_id: Sector.find(@p.current_sector).port.id, status: 'open', qty: 10, commodity: 'ore', trade_type: 'buy', initial_offer: 3000)
      Rails.configuration.trading_strategy = DummyStrategy
    end

    it 'permits making a counteroffer to a port (high offer) and receives a counteroffer in return' do
      offer_amount = 1000
      post '/api/subspace/transactions/offer', params: { id: @transaction.uid, amount: offer_amount }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('offer')
      expect(transaction['offer']['amount']).to be < offer_amount
    end

    it 'permits making a counteroffer to a port (low offer) and receives a transaction termination in return' do
      offer_amount = 15
      post '/api/subspace/transactions/offer', params: { id: @transaction.uid, amount: offer_amount }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('errors')
    end

    it 'permits making a counteroffer to a port (optimal offer) which is accepted' do
      offer_amount = 20
      post '/api/subspace/transactions/offer', params: { id: @transaction.uid, amount: offer_amount }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('transaction')
    end
  end

  describe 'Transaction handling (Default Trading Strategy)' do
    before :all do
      @player = Player.last
      @p.current_sector = 2
      @player.save

      @transaction = Transaction.create(player_id: @p.id, port_id: 2, status: 'open', qty: 10, commodity: 'ore', trade_type: 'buy', initial_offer: 3000)
      Rails.configuration.trading_strategy = DefaultStrategy
    end

    it 'permits making a counteroffer to a port (high offer) and receives a counteroffer in return' do
      offer_amount = 2300
      post '/api/subspace/transactions/offer', params: { id: @transaction.uid, amount: offer_amount }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('offer')
      expect(transaction['offer']['amount']).to be < offer_amount
    end

    it 'permits making a counteroffer to a port (low offer) and receives a transaction termination in return' do
      offer_amount = 10
      post '/api/subspace/transactions/offer', params: { id: @transaction.uid, amount: offer_amount }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('errors')
    end

    it 'permits making a counteroffer to a port (optimal offer) which is accepted' do
      offer_amount = 2900
      post '/api/subspace/transactions/offer', params: { id: @transaction.uid, amount: offer_amount }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      transaction = JSON.parse(response.body)
      expect(transaction).to have_key('transaction')
    end
  end
end
