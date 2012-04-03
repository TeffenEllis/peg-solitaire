require './models/decorator'

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
        @tiles[x][y] = ' '
      end
    end

    # Remove a random piece
    # x = rand(5)
    # y = rand(5)
    # @tiles[x][y] = ' '
    @tiles[1][3] = '*'
    @tiles[1][4] = '*'

  end

  def render
    print "   "
    x_axis = ('A'..((@tiles.size - 1 ) + 65).chr)
    x_axis.each { |l| print "#{l} " }

    Decorator.border(@tiles.size)

    @tiles.each_with_index do |row, i|
      i = i+1
      print "#{i} |"
      row.each do |square|
        print "#{square}|"        
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
    if valid?(start_piece, end_piece)
      @tiles[start_piece[:x]][start_piece[:y]] = ' '
      @tiles[end_piece[:x]][end_piece[:y]] = '*'
    else
      puts "That move is incorrect."
    end
  end

  def valid?(start_piece, end_piece)
    pieces = [start_piece, end_piece]

    pieces.each do |piece|
      # Check if piece is on the board
      puts piece
      puts @tiles[piece[:x]][piece[:y]]
      return false unless piece[:x] >= 0 && \
                          piece[:x] <= @tiles.size && \
                          piece[:y] >= 0 && \
                          piece[:y] <= @tiles.size
    end
    # Check if start piece exists
    return false unless @tiles[pieces[0][:x]][pieces[0][:y]] == '*'
    # Check if end piece is occupied
    return false unless @tiles[pieces[1][:x]][pieces[1][:y]] == ' '

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
    return false unless (x_direction.nil? || y_direction.nil?)



    # Determine what's underneath us as we jump
    delta = {} # denotes change in two points
    gamma = {} # denotes jumped piece
    delta[:x] = (pieces[0][:x] - pieces[1][:x])
    delta[:y] = (pieces[0][:y] - pieces[1][:y])

    gamma[:x] = (pieces[0][:x] + delta[:x])
    gamma[:y] = (pieces[0][:y] + delta[:y])


    return true
  end
end
