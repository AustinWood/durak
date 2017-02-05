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
    it "accepts an array of players" do
      expect(game.players.count).to eq(4)
    end
  end

  describe "#deal_cards" do
    it "deals starting hand to each player" do
      players.each do |player|
        expect(player).to receive(:deal)
      end
      game.deal_cards
    end
  end

  describe "#set_trump_card" do
    it "removes top-most card from deck and sets as trump card" do
      game.set_trump_card
      expect(game.trump_card).to be_instance_of(Card)
    end
  end

  describe "#loser?" do
    it "returns true when there is only one player remaining" do
      players = [Player.new("Yuri Gagarin")]
      game = Game.new(players)
      expect(game.loser?).to eq(true)
    end

    it "returns false when there are multiple players remaining" do
      players = [Player.new("Yuri Gagarin"), Player.new("Mikhail Gorbachev")]
      game = Game.new(players)
      expect(game.loser?).to eq(false)
    end
  end

  describe "#take_turn" do

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
end
