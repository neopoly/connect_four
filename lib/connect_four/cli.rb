require "connect_four/player"

module ConnectFour
  class CLI
    COLUMN_DIVIDER = "|"
    DEFAULT_COLOR = "white"

    COLOR = {
      "black" => 0,
      "red" => 1,
      "green" => 2,
      "yellow" => 3,
      "blue" => 4,
      "magenta" => 5,
      "cyan" => 6,
      "white" => 7,
    }

    QUIT_MESSAGE = "Do you want to quit? (y/n) "
    FULL_MESSAGE = "The board is full. It is a draw!"
    RANGE_ERROR = "The column number is out of range."
    FULL_ERROR = "This column is full."
    NOT_VALID_ERROR = "Your input is not a valid column number!"
    NO_VALID_PLAYER_ERROR = "The player info you entered is not valid."
    NO_VALID_COLOR_ERROR = "The color you entered is not valid."
    NO_VALID_PIECE_ERROR = "Your piece has to be \e[1mone\e[0m character."
    PIECE_IN_USE_ERROR = "This piece is already in use"

    def initialize(input = $stdin, output = $stdout)
      @input = input
      @output = output
    end

    def welcome
      print_line "Welcome to Connect Four!"
    end

    def ask_for_player_data
      num_players = ask_player_number
      print_line "Who wants to play? (name color piece)"
      print "Valid colors: "
      print_line COLOR.map { |key, val| color(key, key) }.join(", ")

      player_data = (1..num_players).inject([]) do |players, i|
        players << ask_player_data(players, i)
      end

      print_line "Enter #{em "exit"} or #{em "quit"} to leave."
      blank_line

      player_data
    end

    def ask_player_number
      valid = false
      until valid
        print "How many players want to play? (2-8) "
        num_string = read
        valid = if num_string.match /[0-9]+/
            true
          else
            error_message "Not a number."
            false
          end

        valid &&= if ("2".."8").include? num_string
            true
          else
            error_message "Player number not in range."
            false
          end
      end
      num_string.to_i
    end

    def ask_player_data(players, i)
      valid = false
      until valid
        print "Player #{i}: "
        args = read.split(" ")

        valid = case args.length
          when 2
            name, piece = args
            color_string = DEFAULT_COLOR
            true
          when 3
            name, color_string, piece = args
            true
          else
            error_message NO_VALID_PLAYER_ERROR
            false
          end

        valid &&= if color_string_valid? color_string
            true
          else
            error_message NO_VALID_COLOR_ERROR
            false
          end

        valid &&= if piece_string_valid? piece
            true
          else
            error_message NO_VALID_PIECE_ERROR
            false
          end

        valid &&= if not piece_used? players, piece
            true
          else
            error_message PIECE_IN_USE_ERROR
            false
          end
      end

      piece = color(color_string, piece)
      Player.new(name, piece)
    end

    def draw_interface(game_state)
      @board_state = game_state[0]
      @current_player = game_state[1]

      print column_numbers
      print board_string
      blank_line
      blank_line
      clear_line
      move_prev_line
      clear_line
    end

    def get_input_column
      valid = false
      until valid
        print player_move_line
        input_string = read
        if input_string.match? /[0-9]+/
          valid = true
        elsif input_string == "exit" or input_string == "quit"
          quit_message
        else
          error_message NOT_VALID_ERROR
        end
      end
      input_string.to_i
    end

    def reset
      print "\e[#{@board_state.length + 3}F"
    end

    def error_message(string)
      clear_line
      print color("red", string)
      move_prev_line
      clear_line
    end

    def range_error
      error_message RANGE_ERROR
    end

    def full_error
      error_message FULL_ERROR
    end

    def quit_message
      move_prev_line
      clear_line
      print(color "green", QUIT_MESSAGE)
      input_string = read
      exit if input_string == "y"
      move_prev_line
      clear_line
    end

    def win_message(game_state)
      @board_state = game_state[0]
      winner = game_state[1]
      print column_numbers
      print board_string
      blank_line
      print_line color("green", "#{winner} has won!")
      clear_line
    end

    def full_message(game_state)
      @board_state = game_state[0]
      winner = game_state[1]
      print column_numbers
      print_line board_string
      blank_line
      print_line color("yellow", FULL_MESSAGE)
      clear_line
    end

    private

    def args_length_valid?(length)
      args.length.between? 2, 3
    end

    def color_string_valid?(color_string)
      COLOR.key? color_string
    end

    def piece_string_valid?(piece)
      piece.length == 1
    end

    def piece_used?(players, piece)
      players.map { |player| player.piece }.include? piece
    end

    def board_string
      @board_state.map do |row|
        row.map do |piece|
          piece or "."
        end.join(COLUMN_DIVIDER) << "\n"
      end.join
    end

    def column_numbers
      (1..@board_state.length).to_a.join(COLUMN_DIVIDER) << "\n"
    end

    def player_move_line
      player_piece = @current_player.piece
      "#{@current_player} (#{player_piece}): "
    end

    def print(string)
      clear_line
      @output.print string
    end

    def blank_line
      clear_line
      @output.puts
    end

    def print_line(string)
      clear_line
      @output.puts string
    end

    def read
      @input.gets.strip
    end

    def color(color, string)
      "\e[3#{COLOR[color]}m#{string}\e[0m"
    end

    def move_prev_line(num = 1)
      @output.print "\e[#{num}F"
    end

    def clear_line
      @output.print "\e[K"
    end

    def em(string)
      "\e[1m\e[3m#{string}\e[0m"
    end
  end
end
