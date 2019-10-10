require_relative 'card_deck'
require_relative 'player'

class Game

  attr_reader :player, :dealer, :bet_amount, :deck

  def initialize
    name = gets.chomp
    @player = Player.new (name)
    @dealer = Dealer.new ('Дилер')
    @bet_amount = 10
  end

  def bets                            #Начало раунда 
    @player.bank -= @bet_amount if @player.bank >= @bet_amount  #сделали ставки
    @dealer.bank -= @bet_amount if @dealer.bank >= @bet_amount  #потом здесь исключение или проверку на проигрыш
  end

  def can_make_bets?
    @player.bank != 0 || @dealer.bank != 0
  end

  def reshuffle
    @deck = CardDeck.new                      #Взяли новую колоду
    @deck.reshuffle                           #Перемешали
  end
  
  def deals_cards
    @player.take_card(@deck)                         #раздаем карты
    @dealer.take_card(@deck)
    @player.take_card(@deck)
    @dealer.take_card(@deck)
  end

  def player_turn
    loop do
      break if @player.busted? || @player.blackjack?
      key = gets.to_i
      case key
      when 1 #еще
        @player.take_card
        @dealer.count_points
      when 2
        break
      end
    end
  end

  def dealer_turn
    puts @dealer.show_hand
    puts @dealer.count_points
    return if !@dealer.should_take_another? (@player)
    loop do
      @dealer.take_card(@deck)
      puts @dealer.show_hand
      puts @dealer.count_points
      next if @dealer.should_take_another? (@player)
      break
    end
  end

  def dealer_win
    @dealer.bank  += @bet_amount * 2
  end

  def player_win
    @player.bank  += @bet_amount * 2
  end

  def return_cards
    @player.hand = []
    @dealer.hand = []
  end
end