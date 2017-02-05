require 'player'
require 'deck'

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
      deck = Deck.new
      player.deal(deck)
      expect(player.cards.count).to eq(6)
    end
  end

  context "while taking a turn" do
    let(:cards) do
      cards = [
        Card.new(:hearts, :queen),
        Card.new(:hearts, :king),
        Card.new(:hearts, :ten),
        Card.new(:clubs, :six),
        Card.new(:clubs, :seven),
        Card.new(:clubs, :nine)
      ]
    end

    before(:each) do
      player.cards = cards
    end

    describe "#attack" do
      it "returns the highest card from the players hand" do
        expect(player.attack.value).to eq(:king)
      end

      it "removes the selected card from the player's cards array" do
        player.attack
        expect(player.cards.count).to eq(5)
      end
    end

    describe "#defend" do
      it "plays the lowest winning card if one exists in hand" do
        attacking_card = Card.new(:spades, :queen)
        trump_card = Card.new(:diamonds, :seven)
        defending_card = player.defend(attacking_card, trump_card)
        expect(defending_card.value).to eq(:king)
        expect(defending_card.suit).to eq(:hearts)
      end

      it "plays a card matching trump suit if it wil beat the attacking card" do

      end

      it "removes the selected card from the player's cards array" do

      end
    end
  end
end
