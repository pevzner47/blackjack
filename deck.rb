require_relative 'card'
require_relative 'validation'
class Deck
  include Validation

  attr_reader :deck
  validate :deck, :arr_type, Card

  

  def initialize
    @deck = create_deck
    validate!
  end 

  def reshuffle
    @deck = @deck.sort_by{ rand }
  end
  
  def give_card
    raise 'В колоде неосталось карт!!!' if @deck.size == 0
    @deck.pop
  end

  private

  def create_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck
  end
end

