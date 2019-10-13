require_relative 'deck'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'
require_relative 'bank'

class Interface

  attr_reader :game

  def game=(value)
    @game = value
  end 

  def get_name
    puts 'Введите ваше имя... ' 
    name = gets.chomp
    name 
  end

  def greeting
    puts "Приветствуем вас, #{@game.player.name}!" 
    puts "Сейчас у вас и у дилера банке #{@game.bank.player_bank}$"
  end

  def game_over
    puts "Игра окончена! Ваш банк #{@game.bank.player_bank}$"
  end

  def start_round 
    puts 'Делаем ставки...'
    puts "-#{@game.bank.bet}$"
    puts ''
    puts 'Тасуем колоду...'
    puts ''
    puts 'Раздаем карты...'
    puts ''
    puts 'Рука дилера'
    puts @game.dealer.show_hiden_hand
    puts ''
    puts 'Ваша рука'
    puts @game.player.hand.show
    puts @game.player.hand.points
    puts ''
  end

  def more?
    puts "1: Еще;  2: Себе"
    gets.to_i
  end

  def show_hand(player)
    puts player.hand.show
    puts player.hand.points
  end

  def busted_message
    puts 'Перебор!'
  end

  def dealer_turn_message
    puts 'Ход дилера'
  end

  def show_player_points
    puts "У вас #{@game.player.hand.points}"
  end

  def input_error_message
    puts 'Ошибка ввода!'
  end

  def you_win_message
    puts 'Вы выиграли!'
  end

  def dealer_win_message
    puts 'Дилер выиграл!'
  end

  def draw_message
    puts 'Ничья!'
  end

  def want_play_more?
    puts "Ваш банк #{@game.bank.player_bank}$ ; Банк дилера #{@game.bank.dealer_bank}$"
    puts 'Играем еще?'
    puts "1: Да;  2: Нет"
    gets.to_i
  end
end