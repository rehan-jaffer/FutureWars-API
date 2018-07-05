require 'rails_helper'
require './spec/support/auth'
require './lib/universe_parser.rb'

describe "Gameplay" do

  let(:auth) { authenticate_user }

  before(:all) do
    # fixing the value of the seed results in the same universe being created every time meaning predictable testing
    srand(6000)
    Universe.create(10) do
      sector 0 do
        add_port "BBS"
        set_home_sector
      end
    end
  end

  describe "Viewing Current Sector" do
  
    it "permits viewing of the current sector" do
      get "/api/sector/current", headers: {'AUTHORIZATION': auth["auth_token"] }
      expect(response).to be_success
    end

    context "Sector Information" do

      before :all do
        get "/api/sector/current", headers: {'AUTHORIZATION': authenticate_user["auth_token"]}
      end

      let(:sector) { JSON.parse(response.body) }

      subject { sector }

      it { should have_key("sector") }
      it { should have_key("warps") }
      it { should have_key("port") }
      it { should have_key("beacon") }

      it "should contain a list of neighbouring sectors as integers" do
        expect(sector["warps"]).to all be_a_kind_of Integer
      end

    end

  end


end
