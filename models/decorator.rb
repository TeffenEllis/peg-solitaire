class Decorator
  def initialize
  end

  def self.banner
    10.times { print '*' }
    print " Pegz ".green
    10.times { print '*' }
    puts "\n"
  end

  def self.clear
    puts "\e[H\e[2J"
    system('cls')
  end

  def self.border(size)
    print "\n  "
    size.times do |l|
      l == (size - 1) ? (print "+-+") : (print "+-")
    end
    print "\n"
  end
end