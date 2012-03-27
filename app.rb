# Made by the Eric Wrights (1 & 2)

require "./models/board.rb"
require "./models/decorator.rb"

require 'pry'
require 'colorize'
require 'ap'

game_board = Board.new(5)


Decorator.banner
game_board.render
game_board.move

# input = 'y'
# while input == 'y'
#   puts "Would you like to play again? (y/n)"
#   input = gets.chomp!
# end

