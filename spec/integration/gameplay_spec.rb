require 'rails_helper'
require './spec/support/auth'
require './lib/universe_parser.rb'

describe 'Gameplay' do

  before(:all) do
    # fixing the value of the seed results in the same universe being created every time meaning predictable testing
    srand(6000)
    Universe.create(10) do
      sector 0 do
        add_port 'BBS'
        set_home_sector
      end
    end
    CreatePlayerService.call("ray", "testpassword", "my ship")
    @auth = authenticate_user("ray", "testpassword")
    @sector_map = Sector.all.map { |n| n.warps }
  end

  describe "Moving between sectors" do

    let(:player) { Player.find_by_username("ray") }

    it "allows warping between sectors" do
      expect(player.current_sector).to eq 1
      sector = @sector_map[1].first
      post '/api/player/move', params: {id: sector}, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq sector
    end

    it "doesn't allow warping between unconnected sectors" do
      expect(player.current_sector).to eq 1
      post '/api/player/move', params: {id: 0}, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq 1
      errors = JSON.parse(response.body)
      expect(errors).to have_key("errors")
      expect(errors["errors"]).to include("These parts of space are not connected")
    end

    it "doesn't allow warping to sectors that do not exist" do
      post '/api/player/move', params: {id: 100000000}, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq 1
      errors = JSON.parse(response.body)
      expect(errors).to have_key("errors")
      expect(errors["errors"]).to include("Not a valid sector ID")
    end

    it "doesn't allow warping when the player has no turns left" do

      player.turns = 0
      player.save

      expect(player.reload.current_sector).to eq 1
      post '/api/player/move', params: {id: 2}, headers: { 'AUTHORIZATION': @auth['auth_token'] }
      expect(player.reload.current_sector).to eq 1
      errors = JSON.parse(response.body)
      expect(errors).to have_key("errors")
      expect(errors["errors"]).to include("You have no turns left")
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
      it { should have_key('beacon') }

      it 'should contain a list of neighbouring sectors as integers' do
        expect(sector['warps']).to all be_a_kind_of Integer
      end
    end
  end
end
