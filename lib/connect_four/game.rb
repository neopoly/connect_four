require "connect_four/player"
require "connect_four/board"
require "logger"

module ConnectFour
  class Game
    def initialize(*players)
      @board = Board.new
      @players = players
      @turn = 0
      @playing = false
      @input_column = nil
      @pieces_to_win = 4

      @logger = Logger.new("logfile.log")
    end

    public

    def playing?
      @playing
    end

    def pass_turn
      @turn = (@turn + 1) % @players.length
    end

    def won?

      # checking four in a column
      check_col = @board.each_column.any? { |column| match_four_in_a_row(column) }

      # checking four in a row
      check_row = @board.each_row.any? { |row| match_four_in_a_row(row) }

      # checking four in diagonals
      check_diagonals = @board.each_diagonal.any? { |diagonal| match_four_in_a_row(diagonal) }

      check_col or check_row or check_diagonals
    end

    def current_player
      @players[@turn]
    end

    def game_state
      [@board.state, current_player]
    end

    def read_input(input_column_number)
      if @board.in_range? input_column_number
        if not @board.column_full? input_column_number
          @input_column = input_column_number
          error = nil
        else
          error = 1
        end
      else
        error = 2
      end
    end

    def update
      @board.put_piece current_player.piece, @input_column
      @input_column = nil
      if won?
        return 1
      elsif @board.full?
        return 2
      end
      return false
    end

    private

    def match_four_in_a_row(row)
      escaped_player_piece_string = Regexp.escape(current_player.piece)
      four_in_a_row_regex = /(#{escaped_player_piece_string}){4}/
      row_string = row.join
      row_string.match?(four_in_a_row_regex)
    end
  end
end
