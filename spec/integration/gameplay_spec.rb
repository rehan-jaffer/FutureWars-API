require 'rails_helper'
require './spec/support/auth'

describe 'Gameplay' do
  before(:all) do
    # fixing the value of the seed results in the same universe being created every time meaning predictable testing
    @player = CreatePlayerService.call('ray', 'testpassword', 'my ship').result
    @auth = authenticate_user('ray', 'testpassword')
    @sector_map = []
    Sector.all.each do |sector|
      @sector_map[sector.id] = sector.warps
    end
  end

  after :all do
    Player.destroy_all
  end

  describe 'Player/Game initialisation' do
    let(:player) { Player.find_by(username: 'ray') }

    it 'puts the player in the initial sector' do
      expect(player.current_sector).to eq Rails.configuration.game['initial_sector']
    end

    it 'puts the player in a merchant cruiser' do
      expect(player.ship_type_name).to eq 'Merchant Cruiser'
    end
  end

  describe 'Moving between sectors' do
    let(:player) { Player.find_by(username: 'ray') }

    it 'allows warping between sectors' do
      expect(@player.current_sector).to eq 1
      sector = @sector_map[1].sample
      post '/api/player/move', params: { id: sector }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(@player.reload.current_sector).to eq sector
    end

    it "doesn't allow warping between unconnected sectors" do
      expect(player.current_sector).to eq 1
      post '/api/player/move', params: { id: 0 }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq 1
      errors = JSON.parse(response.body)
      expect(errors).to have_key('errors')
      expect(errors['errors']).to include('These parts of space are not connected')
    end

    it "doesn't allow warping to sectors that do not exist" do
      post '/api/player/move', params: { id: 100_000_000 }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq 1
      errors = JSON.parse(response.body)
      expect(errors).to have_key('errors')
      expect(errors['errors']).to include('Not a valid sector ID')
    end

    it "doesn't allow warping when the player has no turns left" do
      player.turns = 0
      player.save

      expect(player.reload.current_sector).to eq 1
      post '/api/player/move', params: { id: 2 }, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq 1
      errors = JSON.parse(response.body)
      expect(errors).to have_key('errors')
      expect(errors['errors']).to include('You have no turns left')
    end
  end

  describe 'Viewing Current Sector' do
    it 'permits viewing of the current sector' do
      get '/api/sector/current', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(response).to be_success
    end

    context 'Sector Information' do
      before :all do
        get '/api/sector/current', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      end

      let(:sector) { JSON.parse(response.body) }

      subject { sector }

      it { should have_key('sector') }
      it { should have_key('warps') }
      it { should have_key('port') }
      it { should have_key('beacons') }

      it 'should contain a list of neighbouring sectors as integers' do
        expect(sector['warps']).to all be_a_kind_of Integer
      end
    end
  end
end
