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

  def make_move_player1(x)
    @board.make_move(x, "x")
  end

  def make_move_player2(x)
    @board.make_move(x, "o")
  end

  def play
  end
end
