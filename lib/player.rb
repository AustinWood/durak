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
    selected_card = lowest_card(false)
    selected_card = lowest_card(true) if selected_card.nil?
    @cards.delete(selected_card)
    selected_card
  end

  def defend(attacking_card)
    selected_card = nil
    unless attacking_card.suit == @trump_suit
      selected_card = lowest_card(false, attacking_card.int_val)
    end
    if selected_card.nil?
      min = (attacking_card.suit == @trump_suit ? attacking_card.int_val : nil)
      selected_card = lowest_card(true, min)
    end
    @cards.delete(selected_card)
    selected_card
  end

  def lowest_card(is_trump, min = nil)
    chosen_card = nil
    valid_cards = (is_trump ? trump_cards : non_trump_cards)
    valid_cards.each do |card|
      next unless chosen_card.nil? || chosen_card.int_val > card.int_val
      chosen_card = card if min.nil? || card.int_val > min
    end
    chosen_card
  end

  def trump_cards
    @cards.select { |card| card.suit == @trump_suit }
  end

  def non_trump_cards
    @cards.reject { |card| card.suit == @trump_suit }
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
