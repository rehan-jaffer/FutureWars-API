require 'rails_helper'

describe MessagePlayerService do

  describe "Messaging a Player that exists" do

    before :all do
      @player1 = FactoryBot.create(:player)
      @player2 = FactoryBot.create(:player)
    end

    let(:message_player) { MessagePlayerService.call(@player1.id, @player2.username, "test message").result }

    it "succeeds" do
      expect(message_player).to be_a_kind_of Message
      expect(@player1.sent_messages.size).to be > 0
      expect(@player2.received_messages.size).to be > 0
    end

  end

  describe "Messaging a Player that doesn't exist" do

    before :all do
      @player1 = FactoryBot.create(:player)
    end

    let(:message_player) { MessagePlayerService.call(@player1.id, "bad name", "test message").errors }

    it "succeeds" do
      expect(message_player[:errors]).to include("No known trader with this name")
    end

  end

end
