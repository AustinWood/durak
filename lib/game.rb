require_relative 'player'

class Game
  attr_reader :players

  def initialize(players)
    @players = players
  end
end

if __FILE__ == $PROGRAM_NAME
  players = [
    Player.new("Vladimir Putin"),
    Player.new("Pyotr Tchaykovsky"),
    Player.new("Yuriy Gagarin"),
    Player.new("Mikhail Gorbachov")
  ]
  game = Game.new(players)
  puts "You initialized a new game with the following players:"
  game.players.each do |player|
    puts player.name
  end
end
