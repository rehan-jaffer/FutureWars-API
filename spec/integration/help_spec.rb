require 'rails_helper'
require './spec/support/auth'

describe "Help API" do

  before :all do
    @player = FactoryBot.create(:player)
    @auth = authenticate_user('ray1', 'testpassword')  
  end

  describe "Ship Catalog" do

    it "returns a list of ships" do
      get '/api/ships', headers: { 'AUTHORIZATION': @auth['auth_token'] }
      JSON.parse(response.body)
    end

  end

end
