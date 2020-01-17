require "connect_four/player"
require "connect_four/board"
require "logger"

module ConnectFour
  class Game

    def initialize(board, *players)
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

    # moves cursor to beginning of previous line and clears it
    def move_prev_line(num=1)
      print "\e[#{num}F"
    end

    def clear_line
      print "\e[K"
    end

    def color_red
      "\e[31m"
    end

    def color_green
      "\e[32m"
    end

    def color_yellow
      "\e[33m"
    end

    def reset_graphics
      "\e[0m"
    end

    def to_interface_origin
      print "\e[#{@board.string_height + 2}F"
    end

    def player_move_line
      "#{current_player.name}: "
    end

    def draw_interface
      puts @board
      puts
      puts
      clear_line
      move_prev_line
      clear_line
      print player_move_line
    end

    ## error messages ##

    def error_message(string)
      clear_line
      print color_red + string + reset_graphics
      move_prev_line
      clear_line
      print player_move_line
    end

    def quit_message
      move_prev_line
      clear_line
      print color_green + "Do you want to quit? (y/n) " + reset_graphics
      input_string = gets.strip
      exit if input_string == "y"
      move_prev_line
      clear_line
      print player_move_line
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
      draw_interface
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
              error_message "This column is already full!"
            end
          else
            error_message "This column number is out of range!"
          end
        else
          if input_string == "exit" or input_string == "quit"
            quit_message
          else
            error_message "Your input is not a valid column number!"
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
        puts @board
        puts
        puts color_green + "#{current_player.name} has won!" + reset_graphics
        clear_line
        @playing = false
      end
      if @board.full?
        puts @board
        puts
        puts
        puts color_yellow + "The board is full. It is a draw!" + reset_graphics
        @playing = false
      end
    end
  end
end
