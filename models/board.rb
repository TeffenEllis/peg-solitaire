require './models/decorator'

class Board
  attr_accessor :tiles
  def initialize(size)
    @tiles = []
    size.times do |x|
      @tiles[x] = []
    end

    size.times do |x|
      size.times do |y|
        @tiles[x][y] = '*'
      end
    end
  end

  def render
    print "  "
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
    print "X: "
    x = gets.to_i

    print "Y: "
    y = gets.to_i

    puts "Where would you like to move (#{x},#{y})?"
    print "X: "
    x_to = gets.to_i

    print "Y: "
    y_to = gets.to_i

    if x <= @tiles.size && y <= @tiles.size && x_to <= @tiles.size && y_to <= @tiles.size
      unless @tiles[x_to][y_to] == '*'
        @tiles[x][y] = ' '
        @tiles[x_to][y_to] = '*'
      else
        puts "(#{x_to},#{y_to}) is taken."
      end
    else
      puts "That move is off the chart!"
    end
  end
end
