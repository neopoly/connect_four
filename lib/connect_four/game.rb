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

    def get_input
      value = ""
      value = gets until ConnectFour::Board::VALID_COLUMNS.include?(value.chomp)
      value.to_i - 1
    end

    def there_is_a_winner? row, column
      @board.quartet? row, column
    end

  end
end
