class Board
  attr_accessor :tiles
  def initialize(size)
    @tiles = []
    size.times { |x| @tiles[x] = [] }
  end

  def render
    x_axis = ('a'..(@tiles.size + 97).chr)
    x_axis.each { |l| print " #{l} " }

    @tiles.each do |t| 
      print " #{t} "
    end
  end
end
