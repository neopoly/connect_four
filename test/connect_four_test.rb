require 'test_helper'
require 'board'

class ConnectFourTest < ConnectFourSpec
  def test_hello_world
    assert_equal "hello world", ConnectFour.hello_world
  end
  def test_make_move
    board = Board.new()
    assert_equal true, board.makeMove(1, "x")
  end
  def test_is_valid_move
    board = Board.new()
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    assert_equal false, board.isValidMove(1)
    assert_equal true, board.isValidMove(2)
  end 
  def test_reset_board
    board = Board.new()
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.makeMove(1, "x")
    board.makeMove(1, "o")
    board.resetBoard()
    assert_equal true, board.isValidMove(1)
  end
end
