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
binding.pry
