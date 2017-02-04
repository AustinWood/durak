require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = Hand.new
  end
end
