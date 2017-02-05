require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players

  def initialize(players)
    @deck = Deck.new
    @players = players
  end

  def play
    deal_cards
  end

  # Each player starts with 6 cards in their hand
  def deal_cards
    players.each do |player|
      player.deal(@deck)
    end
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
end
