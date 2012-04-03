# Unused until version 2.
class Player
  @@count = 0
  attr_accessor :score

  def initialize
    @number = @@count + 1
    @@count++
    @score = 0
  end
end