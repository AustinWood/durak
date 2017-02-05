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

  # To simplify game logic, assume that the attacker
  # will always choose to attack with their highest value card.
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
    defending_card = nil
    while defending_card.nil?
      high_val = defend_with_higher_val(attacking_card, trump_card)
      defending_card = high_val unless high_val.nil?
      break unless defending_card.nil?
      trump_defense = defend_with_trump_suit(attacking_card, trump_card)
      defending_card = trump_defense unless trump_defense.nil?
      break unless defending_card.nil?
      defending_card = @cards.first
    end
    @cards.delete(defending_card)
    defending_card
  end

  def defend_with_higher_val(attacking_card, trump_card)
    defending_card = nil
    cards.each do |card|
      next if card.suit == trump_card.suit
      if card.int_val > attacking_card.int_val
        if defending_card.nil? || card.int_val < defending_card.int_val
          defending_card = card
        end
      end
    end
    defending_card
  end

  def defend_with_trump_suit(attacking_card, trump_card)
    defending_card = nil
    cards.each do |card|
      next unless card.suit == trump_card.suit
      if defending_card.nil? || card.int_val < defending_card.int_val
        defending_card = card
      end
    end
    defending_card
  end
end
