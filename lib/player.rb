class Player
  attr_reader :name
  attr_accessor :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def fill_hand(deck)
    until @cards.count >= 6 || deck.count.zero?
      @cards << deck.take_one
    end
  end

  def take(new_cards)
    @cards.concat(new_cards)
  end

  # To simplify game logic, assume that the attacker will always
  # choose to attack with their lowest value card not of the trump suit.
  # If the player only has cards matching the trump suit, then choose
  # from these the card with the lowest value.
  # In real-life gameplay, this is usually the best attaking strategy.
  def attack

  end

  def lowest_card(is_trump, min = nil)
    chosen_card = nil
    #valid_cards =
  end

  def trump_cards
    @cards.select { |card| card.suit == @trump_suit }
  end

  def non_trump_cards

  end

  def remember_trump_suit(trump_suit)
    @trump_suit = trump_suit
  end

  def print_cards
    card_str = "#{@name}'s cards: "
    @cards.each do |card|
      card_str << "#{card}, "
    end
    card_str
  end
end
