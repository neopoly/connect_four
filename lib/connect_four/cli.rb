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
      print_line "Who wants to play?"
      print_line "Player 1: "
      print      "Player 2: \e[A"
      name1 = read
      print "Player 2: "
      name2 = read
      print_line "Enter \e[1m\e[3mexit\e[0m or \e[1m\e[3mquit\e[0m to leave."
      [name1, name2]
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

    def error_message(string)
      clear_line
      color("red")
      print string
      reset
      move_prev_line
      clear_line
      player_move_line
    end

    def quit_message
      move_prev_line
      clear_line
      color("green")
      print QUIT_MESSAGE
      reset
      input_string = read
      exit if input_string == "y"
      move_prev_line
      clear_line
      player_move_line
    end

    def win_message
      print_line @board
      blank_line
      color("green")
      print_line "#{@current_player} has won!"
      reset
      clear_line
    end

    def full_message
      print_line @board
      blank_line
      color("yellow")
      print_line FULL_MESSAGE
      reset
      clear_line
    end

    private

    def player_move_line
      print "#{@current_player}: "
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

    def color(color)
      @output.print "\e[3#{COLOR[color]}m"
    end

    def reset
      @output.print "\e[0m"
    end

    def move_prev_line(num=1)
      @output.print "\e[#{num}F"
    end

    def clear_line
      @output.print "\e[K"
    end
  end
end
