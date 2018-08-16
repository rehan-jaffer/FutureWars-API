require 'rails_helper'

describe TradeWithPortService do

  before :each do
    @sector = FactoryBot.create(:sector, id: 101)
    @port = FactoryBot.create(:port, sector_id: @sector.id, port_class: 2)
    @player = FactoryBot.create(:player)
    @player.update_sector(101)
  end

  describe "Player opening a valid trade with a port" do

    let(:transaction) { TradeWithPortService.call(@player.id, {qty: 10, commodity: "ore", trade_type: "buy"}).result }

    it "permits player to open a transaction" do
      expect(transaction).to have_key(:transaction)
      expect(transaction).to have_key(:initial_offer)
    end

  end

  describe "Player opening a trade with a port for an incompatible trade type" do

    let(:transaction) { TradeWithPortService.call(@player.id, {qty: 10, commodity: "ore", trade_type: "sell"}).errors }

    it "fails" do
      expect(transaction[:errors]).to include("We do not trade that commodity")
    end

  end

  describe "Player opening a trade with a port for a quantity that exceeds current holds" do

    let(:transaction) { TradeWithPortService.call(@player.id, {qty: 50, commodity: "ore", trade_type: "buy"}).errors }

    it "fails" do
      expect(transaction[:errors]).to include("You do not have that many available holds")
    end

  end

  describe "Player opening a trade with a port for a quantity that exceeds current quantity" do

    let(:transaction) { TradeWithPortService.call(@player.id, {qty: @port.ore_qty+1, commodity: "ore", trade_type: "buy"}).errors }

    it "fails" do
      expect(transaction[:errors]).to include("We do not have that quantity")
    end

  end

  describe "Player opening a trade with insufficient data supplied (qty)" do

    let(:transaction) { TradeWithPortService.call(@player.id, {commodity: "ore", trade_type: "buy"}).errors }

    it "fails" do
      expect(transaction[:errors]).to include("Quantity must be supplied")
    end

  end

end
