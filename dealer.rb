class Dealer < Player

  def should_take_another? (player)
    @points < 17 && !player.busted?
  end

  def show_hiden_hand
    hiden_hand = "* *"
  end
end