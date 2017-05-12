module ConnectFour
  class Game
    attr_accessor :board

    def initialize
      @board = Board.new
    end

    def display_board
      puts @board.stringified
    end

    def prompt_for_input symbol
      print "player #{symbol} >".chomp
    end
  end
end
