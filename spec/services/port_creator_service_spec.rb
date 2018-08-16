require 'rails_helper'
require 'pp'

describe PortCreatorService do
  describe '.call' do
    context 'without a sector ID being supplied' do
      it 'returns an error' do
        result = PortCreatorService.call(port_class: 1)
        expect(result.errors[:errors]).to include('Sector must exist')
      end
    end

    context 'with a sector ID (non-existent)' do
      it 'fails' do
        result = PortCreatorService.call(sector_id: 19_999_999_999, port_class: 1)
        expect(result.errors[:errors]).to include('Sector must exist')
      end
    end

    context 'with correct fields' do
      it 'returns a new port' do
        result = PortCreatorService.call(sector_id: 19_999_999_999, port_class: 1)
        expect(result.errors).to have_key(:errors)
      end
    end

    describe "sets up MCIC" do

      let(:port) { PortCreatorService.call(sector_id: 2, port_class: 1).result }

      it "has the MCIC set up for commodities" do
        expect(port.ore_mcic).to be_between -90, 90
        expect(port.organics_mcic).to be_between -75, 75
        expect(port.equipment_mcic).to be_between -65, 65
      end

      it "sets up the initial qty to be ten times the productivity" do
        expect(port.ore_qty).to eq port.ore_productivity*10
        expect(port.organics_qty).to eq port.organics_productivity*10
        expect(port.equipment_qty).to eq port.equipment_productivity*10
      end

    end

  end
end
