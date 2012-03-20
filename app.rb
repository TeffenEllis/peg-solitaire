# Made by the Eric Wrights (1 & 2)

require "./models/board.rb"
require "./models/decorator.rb"

require 'pry'
require 'colorize'
require 'ap'

display = Decorator.new
game_board = Board.new(5)


display.banner
game_board.render

# input = 'y'
# while input == 'y'
#   puts "Would you like to play again? (y/n)"
#   input = gets.chomp!
# end

