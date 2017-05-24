module ConnectFour
  class Game
    attr_accessor :board

    def initialize
      @board = Board.new
    end

    def display_board
      puts @board.stringified
    end

    def prompt_for_input(symbol)
      print "player #{symbol} >".chomp
    end

    def get_input
      value = ''
      value = gets until ConnectFour::Board::VALID_COLUMNS.include?(value.chomp)
      value.to_i - 1
    end

    def there_is_a_winner?(row, column)
      @board.quartet? row, column
    end

    def play(symbol)
      display_board
      prompt_for_input symbol
      coords = nil
      coords = @board.put_stone(symbol, get_input) while coords.nil?
      coords
    end

    def start
      ConnectFour::Board::NUMBER_OF_FIELDS.times do |i|
        row, column = play symbol = (i += 1).even? ? 'o' : 'x'
        if there_is_a_winner? row, column
          display_board
          puts "THE WINNER IS player #{symbol}"
          break
        end
      end

    end
  end
end
