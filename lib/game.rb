require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players, :trump_card

  def initialize(players)
    @deck = Deck.new
    @players = players
    @tump_card = nil
  end

  def play
    deal_cards
    set_trump_card
    select_first_attacker
    take_turn until loser?
    puts "Game over!"
  end

  def deal_cards
    players.each { |player| player.deal(@deck) }
  end

  def set_trump_card
    @trump_card = @deck.take_one
  end

  # Rotate the @players array so that the Player at i = 0
  # is the player with the lowest card matching the trump suit
  def select_first_attacker
    lowest_card_val = nil
    first_attacker_idx = 0
    players.each.with_index do |player, i|
      player.cards.each do |card|
        next unless card.suit == trump_card.suit
        if lowest_card_val.nil? || card.int_val < lowest_card_val
          lowest_card_val = card.int_val
          first_attacker_idx = i
        end
      end
    end
    @players.rotate!(first_attacker_idx)
  end

  def loser?
    @players.count == 1
  end

  def take_turn

  end

  def attacker
    players[0]
  end

  def defender
    players[1]
  end

end

if __FILE__ == $PROGRAM_NAME
  players = [
    Player.new("Pyotr Ilyich Tchaikovsky"),
    Player.new("Yuri Gagarin"),
    Player.new("Vladimir Putin"),
    Player.new("Mikhail Gorbachev")
  ]
  game = Game.new(players)
  puts "You initialized a new game with the following players:"
  game.play
  game.players.each do |player|
    puts player.name
    p player.cards
  end
  game.select_first_attacker
end
