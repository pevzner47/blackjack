require_relative 'validation'
class Card
  include Validation

  attr_reader :name, :value
  validate :name, :format, /^([2-9AKQJ]|(10))([+^]|<(3|>))$/

  def initialize (name)
    @name = name
    @value = value
    validate!
    end

  def value
    case @name[0]
    when '2'..'9'
      @value = @name.to_i
    when '1', 'J', 'Q', 'K'
      @value = 10
    when 'A'
      @value = 11
    end
  end
end