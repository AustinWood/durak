require 'game'

describe Game do
  let(:players) do
    players = [
      Player.new("Vladimir Putin"),
      Player.new("Pyotr Tchaykovsky"),
      Player.new("Yuriy Gagarin"),
      Player.new("Mikhail Gorbachov")
    ]
  end

  subject(:game) { Game.new(players) }

  describe "#initialize" do
    it "accepts an array of players" do
      expect(game.players.count).to eq(4)
    end
  end


end
