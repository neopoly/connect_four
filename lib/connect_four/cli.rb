module ConnectFour
  class CLI

    QUIT_MESSAGE = "Do you want to quit? (y/n) "
    FULL_MESSAGE = "The board is full. It is a draw!"

    COLOR = {
      "black" => 0,
      "red" => 1,
      "green" => 2,
      "yellow" => 3,
      "blue" => 4,
      "magenta" => 5,
      "cyan" => 6,
      "white" => 7
    }

    def initialize(input=$stdin, output=$stdout)
      @input = input
      @output = output
    end

    def start_screen
      print_line "Welcome to Connect Four!"
      print_line "Who wants to play? (name, color, piece)"
      print_line "Player 1: "
      print      "Player 2: \e[A"
      name1, color1, piece1 = read.split(" ")
      print "Player 2: "
      name2, color2, piece2 = read.split(" ")
      print_line "Enter \e[1m\e[3mexit\e[0m or \e[1m\e[3mquit\e[0m to leave."
      [[name1, color(color1, piece1)], [name2, color(color2, piece2)]]
    end

    def draw_interface(board, current_player)
      @board = board
      @current_player = current_player

      print_line board
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

    def error_message(string)
      clear_line
      print(color "red",string)
      move_prev_line
      clear_line
      player_move_line
    end

    def quit_message
      move_prev_line
      clear_line
      print(color "green",QUIT_MESSAGE)
      input_string = read
      exit if input_string == "y"
      move_prev_line
      clear_line
      player_move_line
    end

    def win_message
      print_line @board
      blank_line
      print_line(color "green","#{@current_player} has won!")
      clear_line
    end

    def full_message
      print_line @board
      blank_line
      pritn_line(color "yellow",FULL_MESSAGE)
      clear_line
    end

    private

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

    def move_prev_line(num=1)
      @output.print "\e[#{num}F"
    end

    def clear_line
      @output.print "\e[K"
    end
  end
end
