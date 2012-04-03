# Made by the Eric Wrights (1 & 2)

require "./models/board.rb"
require "./models/decorator.rb"

require 'pry'
require 'colorize'
require 'ap'

$DEBUG = false

game_board = Board.new(5)

Decorator.clear
Decorator.banner

game_over = false
until game_over
  game_board.render
  game_board.move
  game_over = true if game_board.no_neighbors?
  puts "Next..."
  gets
  Decorator.clear
  #game_board.check
end

# input = 'y'
# while input == 'y'
#   puts "Would you like to play again? (y/n)"
#   input = gets.chomp!

# end

