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

  describe "#fill_hand" do
    it "puts cards in the player's hand until they have 6 cards" do
      deck = Deck.new
      player.fill_hand(deck)
      expect(player.cards.count).to eq(6)
    end

    it "does nothing if the deck is empty"
  end

  describe "#take" do
    it "adds cards to a player's hand" do
      card = Card.new(:hearts, :queen)
      player.take([card])
      expect(player.cards.count).to eq(1)
    end
  end

  ################################
  ### TODO: Fix these specs... ###
  ################################

  context "while taking a turn" do
    let(:cards) do
      cards = [
        Card.new(:hearts, :ten),
        Card.new(:hearts, :queen),
        Card.new(:hearts, :king),
        Card.new(:clubs, :six),
        Card.new(:clubs, :seven),
        Card.new(:clubs, :nine)
      ]
    end

    before(:each) do
      player.cards = cards
    end

    describe "#attack" do
      # it "returns the lowest card from the players hand" do
      #   expect(player.attack.value).to eq(:king)
      # end

      # it "removes the selected card from the player's cards array" do
      #   player.attack
      #   expect(player.cards.count).to eq(5)
      # end

      it "chooses the lowest-value card from the player's hand" do
        player.remember_trump_suit(:spades)
        expect(player.attack.value).to eq(:six)
      end

      it "does not choose a trump-card if others are available" do
        player.remember_trump_suit(:clubs)
        expect(player.attack.value).to eq(:ten)
      end

      it "removes the selected card from the player's cards array"
    end

    describe "#defend" do
      # it "returns the lowest-value non-trump-suit winning card if one exists in hand" do
      #   attacking_card = Card.new(:spades, :queen)
      #   trump_card = Card.new(:diamonds, :seven)
      #   defending_card = player.defend(attacking_card, trump_card)
      #   expect(defending_card.value).to eq(:king)
      #   expect(defending_card.suit).to eq(:hearts)
      # end
      #
      # it "returns lowest-value trump-suit card if it wil beat the attacking card" do
      #   attacking_card = Card.new(:spades, :ace)
      #   trump_card = Card.new(:clubs, :eight)
      #   defending_card = player.defend(attacking_card, trump_card)
      #   expect(defending_card.value).to eq(:six)
      #   expect(defending_card.suit).to eq(:clubs)
      # end
      #
      # it "returns any card in the hand if no winning move is possible" do
      #   attacking_card = Card.new(:spades, :ace)
      #   trump_card = Card.new(:spades, :eight)
      #   defending_card = player.defend(attacking_card, trump_card)
      #   expect(defending_card).to be_instance_of(Card)
      # end
      #
      # it "removes the selected card from the player's cards array" do
      #   attacking_card = Card.new(:spades, :ace)
      #   trump_card = Card.new(:spades, :eight)
      #   player.defend(attacking_card, trump_card)
      #   expect(player.cards.count).to eq(5)
      # end
    end
  end
end
