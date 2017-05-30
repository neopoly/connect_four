require 'board'

class Game
  def initialize
    @board, @moves, @game_over = Board.new, 0, false
  end

  def reset_game
    @board.reset_board
    @moves = 0
    @game_over = false
  end

  def make_move_player1(column)
    @board.make_move(column, "x")
  end

  def make_move_player2(column)
    @board.make_move(column, "o")
  end
  
  def did_player1_win?(column)
    @board.are_four_connected?(column, "x")
  end

  def did_player2_win?(column)
    @board.are_four_connected?(column, "o")
  end

  def get_move_pos
    puts("Please enter the number of the column you wish to insert your piece into.")
    move_pos = gets.chomp.to_i
    while move_pos < 1 || move_pos > 8 do
      puts("Your last input was invalid. Please only enter numbers between 1 and 8.")
      move_pos = gets.chomp.to_i
    end
    return move_pos
  end

  def play
  end
end
