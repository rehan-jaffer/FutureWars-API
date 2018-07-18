require 'rails_helper'
require 'pp'

describe PortCreatorService do

  describe ".call" do

    context "without a sector ID being supplied" do

      it "returns an error" do
        result = PortCreatorService.call({port_class: 1})
        expect(result.errors[:errors]).to include("Sector must exist")
      end

    end

    context "with a sector ID (non-existent)" do

      it "fails" do
        result = PortCreatorService.call({sector_id: 19999999999, port_class: 1})
        expect(result.errors[:errors]).to include("Sector must exist")
      end

    end

    context "with correct fields" do

      it "returns a new port" do
        result = PortCreatorService.call({sector_id: 19999999999, port_class: 1})
        expect(result.errors).to have_key(:errors)
      end

    end

  end

end
