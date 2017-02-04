require 'player'

describe Player do
  subject(:player) { Player.new("Yuriy Gagarin") }

  describe "#initialize" do
    it "assigns the name" do
      expect(player.name).to eq("Yuriy Gagarin")
    end

    it "starts with an empty hand" do
      expect(player.hand.cards).to be_instance_of(Array)
      expect(player.hand.cards.count).to eq(0)
    end
  end
end
