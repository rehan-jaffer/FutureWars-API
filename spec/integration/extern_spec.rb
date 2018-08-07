require 'rails_helper'

describe "External functionality" do

  describe "#map" do
    it "returns an array" do
      get '/api/extern/map'
      result = JSON.parse(response.body)
      expect(result).to be_a_kind_of Array
    end
  end

end
