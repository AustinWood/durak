require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players, :trump_card

  def initialize(players)
    @deck = Deck.new
    @players = players
    @trump_suit = nil
    @turns = 0
  end

  def play
    fill_hands
    set_trump_card
    select_first_attacker
    take_turn until loser? || @turns >= 100
    declare_loser
  end

  def fill_hands
    players.each { |player| player.fill_hand(@deck) }
  end

  def set_trump_card
    @trump_suit = @deck.reveal_trump_suit
    players.each { |player| player.remember_trump_suit(@trump_suit) }
    puts "The trump suit is #{@trump_suit}"
  end

  # Rotate the @players array so that the Player at i = 0
  # is the player with the lowest card matching the trump suit
  def select_first_attacker
    lowest_card_val = nil
    first_attacker_idx = 0
    players.each.with_index do |player, i|
      player.cards.each do |card|
        next unless card.suit == @trump_suit
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
    @turns += 1
    puts "----------------"
    players.each { |player| puts player.print_cards }
    puts "\n"
    attacking_card = attacker.attack
    defending_card = defender.defend(attacking_card)
    puts "#{attacker.name} attacked with #{attacking_card}"
    puts "#{defender.name} defended with #{defending_card}"
    attack_successful = attacker_wins?(attacking_card, defending_card)
    puts (attack_successful ? "Attacker wins!" : "Defender wins!")
    if defending_card.nil?
      defender.take([attacking_card])
    else
      defender.take([attacking_card, defending_card]) if attack_successful
    end
    attack_successful ? @players.rotate!(2) : @players.rotate!(1)
    remove_cardless_players
  end

  def attacker_wins?(attacking_card, defending_card)
    return true if defending_card.nil?
    if attacking_card.suit == @trump_suit
      return true unless defending_card.suit == @trump_suit
    end
    if defending_card.suit == @trump_suit
      return false unless attacking_card.suit == @trump_suit
    end
    defending_card.int_val < attacking_card.int_val
  end

  def remove_cardless_players
    cardless_players = []
    @players.each do |player|
      next unless player.cards.count.zero?
      cardless_players << player
      puts "#{player.name} is cardless!"
    end
    @players = @players - cardless_players
  end

  def attacker
    players[0]
  end

  def defender
    players[1]
  end

  def declare_loser
    puts "----------------"
    if @players.count.zero?
      puts "There was no дурак this game!"
    else
      puts "#{@players.first.name} is the дурак!"
    end
    puts "The trump suit was #{@trump_suit}"
    puts "This game took #{@turns} turns"
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
  end
  game.play
end
