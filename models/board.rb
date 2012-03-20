class Board
  attr_accessor :tiles
  def initialize(size)
    @tiles = []
    size.times do |x|
      @tiles[x] = ['X']
    end
  end

  def render
    print "  "
    x_axis = ('A'..((@tiles.size - 1 ) + 65).chr)
    x_axis.each { |l| print "#{l} " }
    print "\n  "
    @tiles.each_index { |l| l == (@tiles.size - 1) ? (print '+') : (print '+-') }
    print "\n"

    @tiles.each_with_index do |row, i|
      i = i+1
      print "#{i} |"
      row.each do |square|
        print "#{square}|"
        print "\n  "
        @tiles.each_index { |l| l == (@tiles.size - 1) ? (print '+') : (print '+-') }
        print "\n"
      end
    end
  end
end
