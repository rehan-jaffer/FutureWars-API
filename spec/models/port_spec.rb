require 'rails_helper'

RSpec.describe Port, type: :model do
  describe '.to_s' do
    let(:sector) { FactoryBot.create(:sector, id: 16) }
    let(:port) { FactoryBot.create(:port, port_class: 2, sector_id: sector.id) }

    context 'when class 0' do
      it "stringifies as 'Special'" do
        port.port_class = 0
        expect(port.to_s).to eq 'Special'
      end
    end

    context 'when class 2' do
      it "stringifies as 'BBS'" do
        port.port_class = 1
        expect(port.to_s).to eq 'BBS'
      end
    end
  end
end
