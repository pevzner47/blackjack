require_relative 'validation'
class Player
  include Validation

  attr_reader :name, :points
  attr_accessor :bank, :hand

  validate :name, :presence

  def initialize (name)
    @name = name
    @hand = []
    @points = 0
    @bank = 100
    validate!
  end

  def take_card(deck)
    @hand << deck.give_card
  end

  def count_points
    aces = 0
    @points = 0
    @hand.each do |card| 
      @points += card.value
      aces += 1 if card.value == 11
    end
    aces.times {@points -= 10 if @points > 21}
    return @points
  end

  def busted?
    @points > 21
  end

  def blackjack?
    @points == 21
  end

  def win? (player)
    !busted? && (@points > player.points || player.busted?)
  end

  def show_hand
    hand = ""
    @hand.each {|card| hand += "#{card.name} "}
    hand
  end
end