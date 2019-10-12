require_relative 'deck'
require_relative 'player'
require_relative 'bank'

class Game

  attr_reader :player, :dealer, :bet_amount, :deck, :bank

  def initialize
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new('Дилер')
    @bank = Bank.new(100, 100, 10)
  end

  def bets                            #Начало раунда 
    @player.bank -= @bet_amount if @player.bank >= @bet_amount  #сделали ставки
    @dealer.bank -= @bet_amount if @dealer.bank >= @bet_amount  #потом здесь исключение или проверку на проигрыш
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
    @player.hand.count_points
    loop do
      puts "1: Еще;  2: Себе"
      key = gets.to_i
      case key
      when 1 
        @player.take_card(@deck)
        puts @player.hand.show
        @player.hand.count_points
        break if blackjack?(@player) || busted?(@player)
      when 2 
        break
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def dealer_turn
    puts @dealer.hand.show
    puts @dealer.hand.count_points
    return if !@dealer.should_take_another? || busted?(@player)
    loop do
      @dealer.take_card(@deck)
      puts @dealer.hand.show
      puts @dealer.hand.count_points
      next if @dealer.should_take_another?
      break
    end
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