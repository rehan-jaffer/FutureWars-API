require 'rails_helper'

RSpec.describe Sector, type: :model do
  describe '#inbound' do
    before :all do
      FactoryGirl.create(:sector_with_warps)
    end
    it 'returns the correct number of inbound warps' do
      sector = Sector.last
      expect(sector.inbound).to eq 3
    end
  end

  describe '#outbound' do
    before :all do
      FactoryGirl.create(:sector_with_warps)
    end
    it 'returns the correct number of outbound warps' do
      sector = Sector.last
      expect(sector.outbound).to eq 3
    end
  end
end
