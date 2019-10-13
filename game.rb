require_relative 'deck'
require_relative 'player'
require_relative 'bank'

class Game

  attr_reader :player, :dealer, :deck, :bank, :interface

  def initialize(interface)
    @interface = interface
    @interface.game = self
    name = @interface.get_name
    @player = Player.new(name)
    @dealer = Dealer.new('Дилер')
    @bank = Bank.new
  end

  def start
    @interface.greeting
    loop do
      round
      break if !want_play_more?
    end
    @interface.game_over
  end

  private

  def round
    start_round
    player_turn
    dealer_turn
    the_winner_is
  end

  def start_round 
    @bank.make_bets
    reshuffle
    deals_cards
    @interface.start_round 
  end

  def player_turn
    loop do
      case @interface.more?
      when 1 
        @player.take_card(@deck)
        @interface.show_hand(@player)
        break if player_can_take_more?
      when 2 
        break
      else 
        @interface.input_error_message
        next
      end
    end
    @interface.show_player_points
    @interface.busted_message if busted?(@player)
  end

  def dealer_turn
    @interface.dealer_turn_message
    @interface.show_hand(@dealer)
    loop do
      break unless dealer_should_take_another?
      @dealer.take_card(@deck)
      @interface.show_hand(@dealer)
      next if @dealer.should_take_another?
    end
    @interface.busted_message if busted?(@dealer)
  end

  def the_winner_is
    case who_win?
    when 'player'
      @interface.you_win_message
      @bank.player_win
    when 'dealer'
      @interface.dealer_win_message
      @bank.dealer_win
    when 'draw'
      @interface.draw_message
      @bank.draw
    end
    return_cards
  end

  def want_play_more?
    return false if !@bank.can_make_bets?
    loop do
      case @interface.want_play_more?
      when 1 
        return true
        break
      when 2
        return false
        break
      else 
        @interface.input_error_message
        next
      end
    end
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

  def busted?(player)
    player.hand.points > 21
  end

  def blackjack?(player)
    player.hand.points == 21
  end

  def win?(player, opponent)
    !busted?(player) && (player.hand.points > opponent.hand.points || busted?(opponent))
  end

  def player_can_take_more?
    blackjack?(@player) || busted?(@player)
  end

  def dealer_should_take_another?
    @dealer.should_take_another? && !busted?(@player)
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