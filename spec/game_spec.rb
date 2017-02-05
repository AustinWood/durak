require 'game'
require 'player'

describe Game do
  let(:players) do
    players = [
      Player.new("Pyotr Ilyich Tchaikovsky"),
      Player.new("Yuri Gagarin"),
      Player.new("Vladimir Putin"),
      Player.new("Mikhail Gorbachev")
    ]
  end

  subject(:game) { Game.new(players) }

  describe "#initialize" do
    it "creates a new deck" do
      expect(game.deck.count).to eq(36)
    end

    it "accepts an array of players" do
      expect(game.players.count).to eq(4)
    end

    it "starts the number of turns at 0" do
      expect(game.turns).to eq(0)
    end
  end

  describe "#fill_hands" do
    it "fills each player's hand to 6 cards if the deck allows" do
      players.each { |player| expect(player).to receive(:fill_hand) }
      game.fill_hands
    end
  end

  describe "#set_trump_suit" do
    it "saves the trump suit as an instance variable" do
      suits = [:clubs, :diamonds, :hearts, :spades]
      game.set_trump_suit
      expect(suits).to include(game.trump_suit)
    end

    it "informs players of the trump card" do
      players.each { |player| expect(player).to receive(:trump_suit=) }
      game.set_trump_suit
    end
  end

  describe "#remove_cardless_players" do
    it "removes players from the @players array when they have 0 cards remaining" do
      player_a = Player.new("Pyotr Ilyich Tchaikovsky")
      player_a.cards = []
      player_b = Player.new("Yuri Gagarin")
      player_b.cards = [Card.new(:hearts, :queen)]
      players = [player_a, player_b]
      game = Game.new(players)
      game.remove_cardless_players
      expect(game.players.count).to eq(1)
    end
  end

  describe "#attacker" do
    it "returns the first Player in the players array" do
      expect(game.attacker).to eq(players[0])
    end
  end

  describe "#defender" do
    it "returns the second Player in the players array" do
      expect(game.defender).to eq(players[1])
    end
  end

  describe "#loser?" do
    it "returns true when there is only one player remaining" do
      players = [Player.new("Yuri Gagarin")]
      game = Game.new(players)
      expect(game.loser?).to eq(true)
    end

    it "returns true if there are no players remaining" do
      players = []
      game = Game.new(players)
      expect(game.loser?).to eq(true)
    end

    it "returns false when there are multiple players remaining" do
      players = [Player.new("Yuri Gagarin"), Player.new("Mikhail Gorbachev")]
      game = Game.new(players)
      expect(game.loser?).to eq(false)
    end
  end
end
