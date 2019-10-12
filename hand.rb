class Hand

  attr_reader :cards, :points

  def initialize
    @cards=[]
    @points = 0
  end
  
  def count_points
    aces = 0
    @points = 0
    @cards.each do |card| 
      @points += card.value
      aces += 1 if card.value == 11
    end
    aces.times {@points -= 10 if @points > 21}
    @points
  end

  def show
    hand = ""
    @cards.each {|card| hand += "#{card.name} "}
    hand
  end
  
  def return_cards
    @cards = []
  end
end