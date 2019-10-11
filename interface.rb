require_relative 'card_deck'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'

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
    puts "Игра окончена! Ваш банк #{@game.player.bank}$"
  end

  private

  def start_round 
    puts 'Делаем ставки...'
    @game.bets
    puts "-#{@game.bet_amount}$"
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
    puts @game.player.show_hand
    puts ''
  end

  def the_winner_is
    case @game.who_win?
    when 'player'
      puts 'Вы выиграли' 
      @game.player_win
    when 'dealer'
      puts 'Дилер выиграл'
      @game.dealer_win
    when 'draw'
      puts 'Ничья'
      @game.draw
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
    @game.player.count_points
    loop do
      puts "1: Еще;  2: Себе"
      key = gets.to_i
      case key
      when 1 
        @game.player.take_card (@game.deck)
        puts @game.player.show_hand
        @game.player.count_points
        player_turn if !@game.player.busted?
        break
      when 2 
        break
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
    puts "У вас #{@game.player.points}"
    puts 'Перебор!' if @game.player.busted?
  end

  def want_play_more?
    return false if !@game.can_make_bets?
    loop do
      puts "Ваш банк #{@game.player.bank}$ ; Банк дилера #{@game.dealer.bank}$"
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
    puts 'У дилера перебор!' if @game.dealer.busted?
  end
end