module ConnectFour
  class CLI
    QUIT_MESSAGE = "Do you want to quit? (y/n) "
    FULL_MESSAGE = "The board is full. It is a draw!"
    RANGE_ERROR = "The column number is out of range."
    FULL_ERROR = "This column is full."
    NOT_VALID_ERROR = "Your input is not a valid column number!"
    NO_VALID_PLAYER_ERROR = "The player info you entered is not valid."

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
      (1..num_players).map { |i| ask_player_data i }
    end

    def exit_info
      print_line "Enter #{em "exit"} or #{em "quit"} to leave."
      blank_line
    end

    def ask_player_number
      2 # player number constant as of yet
    end

    def ask_player_data(i)
      print "Player #{i}: "
      valid = false
      until valid
        args = read.split(" ")
        valid, name, piece, color_string = check_number_of_arguments args
        # check color string
        # check piece string
      end
      piece = color(color_string, piece)
      [name, piece]
    end

    def check_number_of_arguments(args)
      valid = false
      if args.length >= 2
        if args.length == 2
          name, piece = args[0..1]
        else
          name, color_string, piece = args
        end
        valid = true
      else
        error_message NO_VALID_PLAYER_ERROR, "Player #{i}: "
      end
      [valid, name, piece, color_string]
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
      print player_move_line
    end

    def get_input_column
      valid = false
      until valid
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

    def error_message(string, line_start = player_move_line)
      clear_line
      print(color "red", string)
      move_prev_line
      clear_line
      print line_start
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
      print player_move_line
    end

    def win_message(game_state)
      @board_state = game_state[0]
      winner = game_state[1]
      print column_numbers
      print board_string
      blank_line
      print_line(color "green", "#{winner} has won!")
      clear_line
    end

    def full_message
      print_line board_string
      blank_line
      pritn_line(color "yellow", FULL_MESSAGE)
      clear_line
    end

    private

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
      @output.print string
    end

    def blank_line
      @output.puts
    end

    def print_line(string)
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
