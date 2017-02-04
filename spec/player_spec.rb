require 'player'

describe Player do
  subject(:player) { Player.new("Yuriy Gagarin") }

  describe "#initialize" do
    it "assigns the name" do
      expect(player.name).to eq("Yuriy Gagarin")
    end

    it "starts with an empty hand"
  end
end
