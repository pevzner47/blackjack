require_relative 'card_deck'
require_relative 'card'
require_relative 'player'

deck = CardDeck.new
deck.reshuffle
player = Player.new 'Игрок 1'
player.take_card(deck)
player.take_card(deck)
puts player.show_hand
puts player.count_points
