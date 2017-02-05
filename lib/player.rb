class Player
  attr_reader :name
  attr_accessor :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def deal(deck)
    @cards = deck.take(6)
  end
end
