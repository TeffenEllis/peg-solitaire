require './models/decorator'
require 'colorize'

class Board
  attr_accessor :tiles
  def initialize(size)
    @tiles = []
    size.times do |x|
      @tiles[x] = []
    end

    # Fill board
    size.times do |x|
      size.times do |y|
        @tiles[x][y] = '*'
      end
    end


    # Remove a random piece
    x = rand(5)
    y = rand(5)
    @tiles[x][y] = ' '

  end

  def render
    print "   "
    x_axis = ('A'..((@tiles.size - 1 ) + 65).chr)
    x_axis.each { |l| print "#{l.red} " }

    Decorator.border(@tiles.size)

    @tiles.each_with_index do |row, i|
      i = i+1
      print "#{i.to_s.yellow} |"
      row.each do |square|
        print "#{square.blue}|"        
      end

      # Seperator
      Decorator.border(@tiles.size)
    end
  end

  def move
    puts "What piece would you like to move?"
    print ": "
    input = gets.chomp!.split ''

    # Normalize data
    input[0] = input[0].ord - 97
    input[1] = input[1].to_i - 1
    start_piece = { x: input[1], y: input[0] }


    puts "Where would you like to move (#{input[1]},#{input[0]})?"
    print ": "
    input = gets.chomp!.split ''

    # Normalize data
    input[0] = input[0].ord - 97
    input[1] = input[1].to_i - 1
    end_piece = { x: input[1], y: input[0] }


    # Check if coords are valid.
    valid?(start_piece, end_piece)
  end

  def valid?(start_piece, end_piece)
    pieces = [start_piece, end_piece]

    pieces.each do |piece|
      # Check if piece is on the board
      puts piece
      puts @tiles[piece[:x]][piece[:y]]
      unless piece[:x] >= 0 && \
             piece[:x] <= @tiles.size && \
             piece[:y] >= 0 && \
             piece[:y] <= @tiles.size
                puts "#{piece} is not on the board!"
                return false
      end
    end
    # Check if start piece exists
    unless @tiles[pieces[0][:x]][pieces[0][:y]] == '*'
      puts "Your start piece is not at #{pieces[0]}."
      return false 
    end
    # Check if end piece is occupied
    unless @tiles[pieces[1][:x]][pieces[1][:y]] == ' '
      puts "Your destination of #{pieces[1]} is occupied or off the board."
      return false 
    end

    # Determine direction we're going

    # Up
    if ((pieces[0][:x] - pieces[1][:x]) > 0)
      x_direction = :up 
    # Down
    elsif ((pieces[0][:x] - pieces[1][:x]) < 0)
      x_direction = :down 
    else
      x_direction = nil
    end

    # Left
    if ((pieces[0][:y] - pieces[1][:y]) > 0)
      y_direction = :left 
    # Right
    elsif ((pieces[0][:y] - pieces[1][:y]) < 0) 
      y_direction = :right
    else
      y_direction = nil
    end

    # Check if the move is diagonal
    unless (x_direction.nil? || y_direction.nil?)
      puts "You cannot move diagonally."
      return false 
    end


    # Determine what's underneath us as we jump
    delta = {} # denotes change in two points
    gamma = {} # denotes jumped piece

    delta[:x] = -1 if x_direction == :up
    delta[:x] = 1 if x_direction == :down
    delta[:x] = 0 if x_direction.nil?

    delta[:y] = -1 if y_direction == :left
    delta[:y] = 1 if y_direction == :right
    delta[:y] = 0 if y_direction.nil?

    gamma[:x] = pieces[0][:x] + delta[:x]
    gamma[:y] = pieces[0][:y] + delta[:y]

    unless @tiles[gamma[:x]][gamma[:y]] == '*'
      puts "There must be a piece to jump at #{gamma}."
      return false
    end

    # If we've come this far, the move is valid.
    @tiles[pieces[0][:x]][pieces[0][:y]] = ' '
    @tiles[gamma[:x]][gamma[:y]] = ' '
    @tiles[pieces[1][:x]][pieces[1][:y]] = '*'

    return true
  end

  def no_neighbors?
    neighbors_for = []
    @tiles.size.times do |x|
      neighbors_for[x] = []
    end

    @tiles.size.times do |x|
      @tiles.size.times do |y|
        neighbors_for[x][y] = 0
      end
    end

    @tiles.size.times do |x|
      @tiles.size.times do |y|
        # Skip tiles that are empty
        unless @tiles[x][y] == '*'
          puts "#{x}, #{y} is empty. Skipping." if $DEBUG
          next
        else
          puts "Checking #{x},#{y}." if $DEBUG
          # Up
          if (x-1) >= 0
            neighbors_for[x][y] += 1 if @tiles[x-1][y] == '*'
          end

          # Down
          if (x+1) <= (@tiles.size - 1)
            neighbors_for[x][y] += 1 if @tiles[x+1][y] == '*'
          end

          # Left
          if (y-1) >= 0
            neighbors_for[x][y] += 1 if @tiles[x][y-1] == '*'
          end

          # Right
          if (y+1) <= (@tiles.size - 1)
            neighbors_for[x][y] += 1 if @tiles[x][y+1] == '*'
          end
          puts "#{x},#{y} has #{neighbors_for[x][y]} neighbors." if $DEBUG
        end
      end
    end
    total_neighbors = 0
    neighbors_for.flatten.each { |n| total_neighbors += n }
    total_neighbors == 0 ? true : false 
  end
end
