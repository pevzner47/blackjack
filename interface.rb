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

  def round
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
    player_turn
    puts 'У вас перебор!' if @game.player.busted?
    dealer_turn
    puts "ВЫиграл ли я - #{@game.player.win? (@game.dealer)}"
    puts ''
    puts "Количество очков = #{@game.player.count_points}"
    puts ''
    if @game.player.win? (@game.dealer) then
      puts 'Вы выиграли' 
      @game.player_win
    else 
      puts 'Дилер выиграл'
      @game.dealer_win
    end
    @game.return_cards
  end

  def player_turn
    @game.player.count_points
    puts "1: Еще;  2: Себе"
    key = gets.to_i
    case key
    when 1 
      @game.player.take_card (@game.deck)
      puts @game.player.show_hand
      @game.player.count_points
      player_turn if !@game.player.busted?
    when 2 
      return
    end
  end

  def want_play_more?
    return false if !@game.can_make_bets?
    puts "Ваш банк #{@game.player.bank}$ ; Банк дилера #{@game.dealer.bank}$"
    puts 'Играем еще?'
    puts "1: Да;  2: Нет"
    key = gets.to_i
    case key
    when 1 
      true
    when 2
      false
    #else next
    end
  end

  def dealer_turn
    puts 'Ход дилера'
    @game.dealer_turn
  end

  def start
    loop do
      round
      break if !want_play_more?
    end
    puts "Игра окончена! Ваш банк #{@game.player.bank}$"
  end
end

#алгоритм работает с косяками
# не обновляется рука
# поправить область видимости 
# порабатать с исключениями
# добавить в интерфейс еще методов для красоты
# добавить запись перебор у дилера
# сделать ничью