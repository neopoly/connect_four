require "connect_four/player"
require "connect_four/board"
require "logger"

module ConnectFour
  class Game

    attr_reader :playing

    WIN_STATES = [
      /.*x{4}.*/,
      /.*(x[.\n]{8}){3}x.*/,
      /.*(x[.\n]{7}){3}x.*/,
      /.*(x[.\n]{9}){3}x.*/
      ]

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

    def move_this_line
      print "\e[G"
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
      print "\e[u"
    end

    def player_move_line
      "#{current_player.name}: "
    end

    def draw_interface
      puts @board.column_numbers
      puts @board.to_s
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

    public

    def pass_turn
      @turn = (@turn + 1) % @players.length
    end

    def is_win?
      board_state = @board.inspect
      win = WIN_STATES.map {|state| board_state.match? state} .one?
      @logger.info("win? #{win}")
      win
    end

    def current_player
      @players[@turn]
    end

    def start
      @playing = true
    end

    def render
      #to_interface_origin
      draw_interface
    end

    def read_input
      valid = false
      until valid
        input_string = gets.strip
        if input_string.match? /[0-9]+/
          input_column_number = input_string.to_i
          if @board.in_range? input_column_number
            if not @board.is_full? input_column_number
              valid = true
            else
              error_message "This column is already full!"
            end
          else
            error_message "This column number is out of range!"
          end
        else
          error_message "Your input is not a valid column number!"
        end
      end
      @input_column = input_column_number
    end

    def update
      @board.put_piece current_player.piece, @input_column
      @input_column = nil
      if is_win?
        puts color_green + "#{current_player} has won!" + reset_graphics
        @playing = false
      end
    end
  end
end
