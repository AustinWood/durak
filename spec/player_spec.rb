require 'player'

describe Player do
  subject(:player) { Player.new("Yuriy Gagarin") }

  describe "#initialize" do
    it "creates a new player with a publicly visible name attribute" do
      expect(player.name).to eq("Yuriy Gagarin")
    end
  end
end
