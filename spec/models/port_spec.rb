require 'rails_helper'

RSpec.describe Port, type: :model do

  describe ".commodities" do

    it "returns a list of the commodities" do
      expect(Port.commodities).to eq %w[ore organics equipment]
    end

  end

  describe "#trades" do

    before :all do
      @port = FactoryBot.create(:port, sector_id: 13)
    end

    it "populates the trades hash correctly" do
      expect(@port.trades.keys).to eq ["ore", "organics", "equipment"]
      expect(@port.trades.values).to eq ["B", "B", "S"]
    end

  end

  describe "#trades?" do
    
    before :all do
      @port_c1 = FactoryBot.create(:port, port_class: 1, sector_id: 12)
      @port_c2 = FactoryBot.create(:port, port_class: 2, sector_id: 12)
      @port_c3 = FactoryBot.create(:port, port_class: 3, sector_id: 12)
    end

    it "returns the trades? value correctly (Class 2 Port)" do
      expect(@port_c2.trades?("B", "ore")).to eq true
      expect(@port_c2.trades?("S", "organics")).to eq true
      expect(@port_c2.trades?("S", "equipment")).to eq true
    end

    it "populates the trades? value correctly (Class 3 Port)" do
      expect(@port_c3.trades?("B", "ore")).to eq true
      expect(@port_c3.trades?("S", "organics")).to eq true
      expect(@port_c3.trades?("B", "equipment")).to eq true
    end

  end

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
