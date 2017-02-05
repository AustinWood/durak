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
end
