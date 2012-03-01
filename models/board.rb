class Board
	def initialize
		@tiles = Hash.new
	end

  def print
    @tiles.each { |t| puts t }
  ends
end
