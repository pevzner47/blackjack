require_relative 'validation'
class Card
  include Validation

  SUITS = ['+', '<3', '^', '<>'].freeze
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze

  attr_reader :value

  def initialize(rank, suit)
    @suit = suit 
    @rank = rank
    @value = value_set
    validate!
  end

  def name
    @rank + @suit
  end

  def value_set
    case @rank
    when '2'..'9'
      @value = @rank.to_i
    when '10', 'J', 'Q', 'K'
      @value = 10
    when 'A'
      @value = 11
    end
  end

  private

  def validate!
    raise 'Неправильно указано значение карты!' unless RANKS.include?(@rank)
    raise 'Неправильно указана масть карты!' unless SUITS.include?(@suit)
  end
end