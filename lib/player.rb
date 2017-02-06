class Player
  attr_reader :name
  attr_accessor :cards, :trump_suit

  def initialize(name)
    @name = name
    @cards = []
    @trump_suit = nil
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
  # In real-life gameplay, this is usually the best attaking strategy,
  # as you want to save your high-value cards for defense.
  def attack
    selected_card = lowest_card(non_trump_cards)
    selected_card = lowest_card(trump_cards) if selected_card.nil?
    @cards.delete(selected_card)
    selected_card
  end

  def defend(attacking_card)
    selected_card = nil
    if attacking_card.suit == trump_suit
      selected_card = lowest_card(trump_cards, attacking_card.int_val)
    else
      same_suit_cards = @cards.select { |card| card.suit == attacking_card.suit }
      selected_card = lowest_card(same_suit_cards, attacking_card.int_val)
      selected_card = lowest_card(trump_cards, nil) if selected_card.nil?
    end
    @cards.delete(selected_card)
    selected_card
  end

  def lowest_card(card_subset, min = nil)
    chosen_card = nil
    card_subset.each do |card|
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

  def print_cards
    str_arr = @cards.map { |card| card.to_s }
    cards_str = str_arr.join(", ")
    "#{@name}'s cards: #{cards_str}"
  end
end
