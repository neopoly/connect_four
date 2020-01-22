module ConnectFour
  class CLI
    QUIT_MESSAGE = "Do you want to quit? (y/n) "
    FULL_MESSAGE = "The board is full. It is a draw!"

    COLUMN_DIVIDER = "|"

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

    def start_screen
      print_line "Welcome to Connect Four!"
      num_players = ask_player_number
      print_line "Who wants to play? (name color piece)"
      player_data = (1..num_players).map { |i| ask_player_data i }
      print_line "Enter #{em "exit"} or #{em "quit"} to leave."
      player_data
    end

    def ask_player_number
      2 # player number constant as of yet
    end

    def ask_player_data(i)
      print "Player #{i}: "
      name, color_string, piece = read.split(" ")
      [name, color(color_string, piece)]
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
      player_move_line
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
          error_message "Your input is not a valid column number!"
        end
      end
      input_string.to_i
    end

    def to_interface_origin
      print "\e[#{@board_state.length + 3}F"
    end

    def error_message(string)
      clear_line
      print(color "red", string)
      move_prev_line
      clear_line
      player_move_line
    end

    def quit_message
      move_prev_line
      clear_line
      print(color "green", QUIT_MESSAGE)
      input_string = read
      exit if input_string == "y"
      move_prev_line
      clear_line
      player_move_line
    end

    def win_message
      print column_numbers
      print board_string
      blank_line
      print_line(color "green", "#{@current_player} has won!")
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
      print @current_player
      print " (#{player_piece}): "
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
