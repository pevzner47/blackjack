class Bank

  DEFAULT_BANK = 100
  DEFAULT_BET = 10

  attr_reader :bet, :player_bank, :dealer_bank

  def initialize(player_bank = DEFAULT_BANK, dealer_bank = DEFAULT_BANK, bet = DEFAULT_BET)
    @player_bank = player_bank
    @dealer_bank = dealer_bank
    @bet = bet
    validate!
  end

  def can_make_bets?
    @player_bank >= @bet && @dealer_bank >= @bet
  end

  def make_bets
    if can_make_bets? then
      @player_bank -= @bet
      @dealer_bank -= @bet
    end
  end

  def dealer_win
    @dealer_bank  += @bet * 2
  end

  def player_win
    @player_bank  += @bet * 2
  end

  def draw
    @dealer_bank  += @bet
    @player_bank  += @bet
  end

  private

  def validate!
    raise 'Банк игроков не может быть меньше ставки' if @player_bank < @bet || @dealer_bank < @bet
  end
end