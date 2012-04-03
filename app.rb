# Made by the Eric Wrights (1 & 2)

require "./models/board.rb"
require "./models/decorator.rb"

require 'pry'
require 'colorize'
require 'ap'

$DEBUG = false

input = 'y'

while input == 'y'
  game_board = Board.new(5)

  Decorator.clear

  game_over = false
  until game_over
    Decorator.banner
    game_board.render
    game_board.move

    if game_board.no_neighbors?
      game_over = true
      break;
    end

    Decorator.clear
  end

  puts "You finished with #{game_board.pieces_left} pieces left!"
  puts "Would you like to play again? (y/n)"
  input = gets.chomp!
end

