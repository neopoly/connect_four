require './board'

class Game
  def initialize
    @board, @moves, @game_over = Board.new, 0, false
  end

  def reset_game
    @board.reset_board
    @moves = 0
    @game_over = false
  end

  def make_move_player1(x)
    @board.make_move(x, "x")
  end

  def make_move_player2(x)
    @board.make_move(x, "o")
  end

  def get_move_pos
    puts("Please enter the number of the column you wish to insert your piece into.")
    move_pos = gets.chomp.to_i
    while move_pos < 1 || move_pos > 8 do
      puts("Your last input was invalid. Please only enter numbers between 1 and 8.")
      move_pos = gets.chomp.to_i
    end
  end

  def play
  end
end
