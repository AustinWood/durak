class Player
  attr_reader :name
  attr_accessor :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def deal(deck)
    6.times { @cards << deck.take_one }
  end

  def attack
    highest_card = @cards.first
    cards.each do |card|
      next unless card.int_val > highest_card.int_val
      highest_card = card
    end
    attacking_card = highest_card
    @cards.delete(attacking_card)
    attacking_card
  end

  def defend(attacking_card, trump_card)
    defending_card = @cards.first
    cards.each do |card|

    end
    defending_card
  end

  def defend_with_higher_val(attacking_card, trump_card)

  end

  def defend_with_trump_suit(attacking_card, trump_card)

  end
end
