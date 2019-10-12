require_relative 'deck'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'
require_relative 'bank'

class Interface

  def initialize
    puts 'Введите ваше имя... '
    @game = Game.new
    puts "Приветствуем вас, #{@game.player.name}!"
    puts "Сейчас у вас и у дилера банке #{@game.player.bank}$"
  end

  def start
    loop do
      round
      break if !want_play_more?
    end
    puts "Игра окончена! Ваш банк #{@game.bank.player}$"
  end

  private

  def start_round 
    puts 'Делаем ставки...'
    @game.bank.make_bets
    puts "-#{@game.bank.bet}$"
    puts ''
    puts 'Тасуем колоду...'
    @game.reshuffle
    puts ''
    puts 'Раздаем карты...'
    @game.deals_cards
    puts ''
    puts 'Рука дилера'
    puts @game.dealer.show_hiden_hand
    puts ''
    puts 'Ваша рука'
    puts @game.player.hand.show
    puts ''
  end

  def the_winner_is
    case @game.who_win?
    when 'player'
      puts 'Вы выиграли' 
      @game.bank.player_win
    when 'dealer'
      puts 'Дилер выиграл'
      @game.bank.dealer_win
    when 'draw'
      puts 'Ничья'
      @game.bank.draw
    end
    @game.return_cards
    puts ''
  end

  def round
    start_round
    player_turn
    dealer_turn
    the_winner_is
  end

  def player_turn
    @game.player_turn
    puts "У вас #{@game.player.hand.points}"
    puts 'Перебор!' if @game.busted?(@game.player)
  end

  def want_play_more?
    return false if !@game.bank.can_make_bets?
    loop do
      puts "Ваш банк #{@game.bank.player}$ ; Банк дилера #{@game.bank.dealer}$"
      puts 'Играем еще?'
      puts "1: Да;  2: Нет"
      key = gets.to_i
      case key
      when 1 
        return true
        break
      when 2
        return false
        break
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def dealer_turn
    puts 'Ход дилера'
    @game.dealer_turn
    puts 'У дилера перебор!' if @game.busted?(@game.dealer)
  end
end