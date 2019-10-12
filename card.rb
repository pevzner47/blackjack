require_relative 'validation'
class Card
  include Validation

  SUITS = ['+', '<3', '^', '<>']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  class << self

    def deck
      deck = []
      Card::SUITS.each do |suit|
        Card::RANKS.each do |rank|
          name = rank + suit
          deck << name
        end
      end
      deck
    end
  end

  CARDS = self.deck

  attr_reader :name, :value

  def initialize(name)
    @name = name
    @value = value_set
    validate!
  end

  def value_set
    case @name[0]
    when '2'..'9'
      @value = @name.to_i
    when '1', 'J', 'Q', 'K'
      @value = 10
    when 'A'
      @value = 11
    end
  end

  private

  def validate!
    raise 'Неверный формат карты!' unless CARDS.include?(@name)
    raise 'Неправильно указано значение карты!' unless RANKS.include?(@name[0]) || RANKS.include?(@name[0..1])
    raise 'Неправильно указана масть карты!' unless SUITS.include?(@name[-1]) || SUITS.include?(@name[-2..-1])
  end
end