require 'rails_helper'

describe CreatePlayerService do

  describe "Creating a user" do


    context "No Username Supplied" do
      it "returns with an error" do
        result = CreatePlayerService.call(nil, "testpassword", "shipname")
        expect(result.errors).to have_key(:errors)
      end
    end

    context "No Password Supplied" do
      it "returns with an error" do
        result = CreatePlayerService.call("testuser", nil, "shipname")
        expect(result.errors).to have_key(:errors)
      end
    end

    context "No Ship Name Supplied" do
      it "returns with an error" do
        result = CreatePlayerService.call("testuser", "testpassword", nil)
        expect(result.errors).to have_key(:errors)
      end
    end

  end

end
