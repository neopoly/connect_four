require "connect_four/player"
require "connect_four/board"
require "connect_four/cli"
require "logger"

module ConnectFour
  class Game

    def initialize(cli, board, *players)
      @cli = cli
      @board = board
      @players = players
      @turn = 0
      @playing = false
      @input_column = nil
      @pieces_to_win = 4

      @logger = Logger.new("logfile.log")
    end

    private

    ## Graphics Functions ##

    def to_interface_origin
      print "\e[#{@board.string_height + 2}F"
    end

    def match_four_in_a_row(row)
      four_in_a_row_regex = /#{current_player.piece}{4}/
      row_string = row.join
      row_string.match?(four_in_a_row_regex)
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
      check_col = @board.each_column.any? {|column| match_four_in_a_row(column) } 
      
      # checking four in a row
      check_row = @board.each_row.any? {|row| match_four_in_a_row(row) }
      
      # checking four in diagonals
      check_diagonals = @board.each_diagonal.any? {|diagonal| match_four_in_a_row(diagonal) }

      check_col or check_row or check_diagonals
    end

    def current_player
      @players[@turn]
    end

    def start
      @playing = true
      puts
    end

    def render
      @cli.draw_interface @board, current_player
    end

    def read_input
      valid = false
      until valid
        input_string = gets.strip
        if input_string.match? /[0-9]+/
          input_column_number = input_string.to_i
          if @board.in_range? input_column_number
            if not @board.column_full? input_column_number
              valid = true
            else
              @cli.error_message "This column is already full!"
            end
          else
            @cli.error_message "This column number is out of range!"
          end
        else
          if input_string == "exit" or input_string == "quit"
            @cli.quit_message
          else
            @cli.error_message "Your input is not a valid column number!"
          end
        end
      end
      @input_column = input_column_number
    end

    def update
      @board.put_piece current_player.piece, @input_column
      @input_column = nil
      to_interface_origin
      if won?
        @cli.win_message
        @playing = false
      elsif @board.full?
        @cli.full_message
        @playing = false
      end
    end
  end
end
