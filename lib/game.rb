require_relative 'player'
require_relative 'deck'

require 'byebug'

class Game
  attr_reader :players, :trump_card

  def initialize(players)
    @deck = Deck.new
    @players = players
    @trump_card = nil
  end

  def play
    fill_hands
    set_trump_card
    select_first_attacker
    take_turn until loser?
    puts "Game over!"
  end

  def fill_hands
    players.each { |player| player.fill_hand(@deck) }
  end

  def set_trump_card
    @trump_card = @deck.take_one
    puts "The trump card is #{@trump_card}"
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
    @players.count <= 1
  end

  def take_turn
    gets
    attacking_card = attacker.attack
    defending_card = defender.defend(attacking_card, trump_card)
    puts "\n\n"
    puts "There are #{players.count} players remaining"
    puts "#{attacker.name} has #{attacker.cards.count} cards and attacked with #{attacking_card}"
    puts "#{defender.name} has #{defender.cards.count} cards and defended with #{defending_card}"
    attack_successful = attacker_wins?(attacking_card, defending_card)
    puts (attack_successful ? "Attacker wins!" : "Defender wins!")
    defender.take([attacking_card, defending_card]) if attack_successful
    attack_successful ? @players.rotate!(2) : @players.rotate!(1)
    remove_cardless_players
  end

  def attacker_wins?(attacking_card, defending_card)
    if attacking_card.suit == trump_card.suit
      return true unless defending_card.suit == trump_card.suit
    end
    if defending_card.suit == trump_card.suit
      return false unless attacking_card.suit == trump_card.suit
    end
    defending_card.int_val < attacking_card.int_val
  end

  def remove_cardless_players
    @players.each do |player|
      players.delete(player) if player.cards.count.zero?
    end
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
  game.players.each do |player|
    puts player.name
    p player.cards
  end
  game.play
end
