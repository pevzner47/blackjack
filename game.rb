require_relative 'deck'
require_relative 'player'
require_relative 'bank'

class Game

  attr_reader :player, :dealer, :bet_amount, :deck, :bank

  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new('Дилер')
    @bank = Bank.new(Bank::DEFAULT_BANK, Bank::DEFAULT_BANK, Bank::DEFAULT_BET)
  end

  def reshuffle
    @deck = Deck.new                      #Взяли новую колоду
    @deck.reshuffle                           #Перемешали
  end
  
  def deals_cards
    @player.take_card(@deck)                         #раздаем карты
    @dealer.take_card(@deck)
    @player.take_card(@deck)
    @dealer.take_card(@deck)
  end

  def player_turn
        @player.take_card(@deck)
        @player.hand.points
  end

  def dealer_turn
    return if !@dealer.should_take_another? || busted?(@player)
    @dealer.take_card(@deck)
  end

  def busted?(player)
    player.hand.points > 21
  end

  def blackjack?(player)
    player.hand.points == 21
  end

  def win?(player, opponent)
    !busted?(player) && (player.hand.points > opponent.hand.points || busted?(opponent))
  end

  def who_win?
    return 'player' if win?(@player, @dealer)
    return 'dealer' if win?(@dealer, @player)
    return 'draw' if @player.hand.points == @dealer.hand.points
  end

  def return_cards
    @player.hand.return_cards
    @dealer.hand.return_cards
  end
end