require 'player'

describe Player do
  subject(:player) { Player.new("Yuri Gagarin") }

  describe "#initialize" do
    it "assigns the name" do
      expect(player.name).to eq("Yuri Gagarin")
    end

    it "starts with 0 cards" do
      expect(player.cards).to be_instance_of(Array)
      expect(player.cards.count).to eq(0)
    end
  end

  describe "#deal" do
    it "fills player's hand with 6 cards from the deck" do
      deck = double("deck")
      expect(deck).to receive(:take).with(6)
      player.deal(deck)
    end
  end
end
