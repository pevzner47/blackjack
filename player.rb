require_relative 'validation'
require_relative 'hand'
class Player
  include Validation

  attr_reader :name, :hand 

  validate :name, :presence

  def initialize(name)
    @name = name
    @hand = Hand.new
    validate!
  end

  def take_card(deck)
    @hand.cards << deck.give_card
  end
end