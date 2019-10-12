class Bank

  attr_reader :bet, :player, :dealer

  def initialize(player_bank, dealer_bank, bet)
    @player = player_bank
    @dealer = dealer_bank
    @bet = bet
  end

  def can_make_bets?
    @player >= @bet && @dealer >= @bet
  end

  def make_bets
    if can_make_bets? then
      @player -= @bet
      @dealer -= @bet
    end
  end

  def dealer_win
    @dealer  += @bet * 2
  end

  def player_win
    @player  += @bet * 2
  end

  def draw
    @dealer  += @bet
    @player  += @bet
  end
end