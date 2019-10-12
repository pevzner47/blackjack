require_relative 'validation'
class Card
  include Validation

  SUITS = ['+', '<3', '^', '<>']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  CARDS = ['2+', '3+', '4+', '5+', '6+', '7+', '8+', '9+', '10+', 'J+', 'Q+', 'K+', 'A+', '2<3', '3<3', '4<3', '5<3', '6<3', '7<3', '8<3', '9<3', '10<3', 'J<3', 'Q<3', 'K<3', 'A<3','2^', '3^', '4^', '5^', '6^', '7^', '8^', '9^', '10^', 'J^', 'Q^', 'K^', 'A^', '2<>', '3<>', '4<>', '5<>', '6<>', '7<>', '8<>', '9<>', '10<>', 'J<>', 'Q<>', 'K<>', 'A<>']  


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
    raise 'Неверный формат карты!' if !CARDS.include?(@name)
  end
end