class Card

  attr_reader :name, :value

  def initialize (name)
    @name = name
    @value = value
    #validate (строка, size 2; а лучше формат по регулярочке)
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