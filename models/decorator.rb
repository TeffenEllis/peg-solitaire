class Decorator
  def initialize
  end

  def banner
    10.times { print '*' }
    print " Pegz "
    10.times { print '*' }
    puts "\n Welcome to the game"
  end

  def clear
    puts "\e[H\e[2J"
    system('cls')
  end
end