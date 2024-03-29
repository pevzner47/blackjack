require_relative 'card'
require_relative 'validation'
class CardDeck
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
    @deck = []
    suits = ['+', '<3', '^', '<>']
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
    for i in ranks do
      suits.each {|suit| name = i.to_s + suit; @deck << Card.new(name)}
    end
    @deck
  end
end

