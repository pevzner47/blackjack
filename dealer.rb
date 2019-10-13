require_relative 'game'

class Dealer < Player

  def should_take_another?
    @hand.points < 17
  end

  def show_hiden_hand
    hiden_hand = "* *"
  end
end