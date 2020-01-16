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
      
      @logger = Logger.new "logfile.log"
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

    public

    def playing?
      @playing
    end

    def pass_turn
      @turn = (@turn + 1) % @players.length
    end

    def won?
      # checking four in a column
      check_col = @board.state("cols").any? {|col| col.length > 3 and col.reverse[0..3].all? {|piece| piece == current_player.piece}}
      
      # checking four in a row
      check_row = @board.state("rows").any? {|row| row.join.match?(/#{current_player.piece}{4}/)}
      
      # checking four in top-left to bottom-right diagonals
      check_tl_br = false

      # checking four in top-right to bottom-left diagonals
      check_tr_bl = false

      check_col or check_row or check_tl_br or check_tr_bl
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
        @playing = false
      end
    end
  end
end
