require 'test_helper'

class ConnectFourTest < ConnectFourSpec
  def test_hello_world
    assert_equal "hello world", ConnectFour.hello_world
  end
  def test_reset_board
    board = Array.new(8) { Array.new(8, ".") }
    full_board = Array.new(8) { Array.new(8, "x") }
    assert_equal board, ConnectFour.reset_board(full_board)
  end
  def test_is_valid_move
    board = Array.new(8) { Array.new(8, "x") }
    board[0][0] = "."
    assert_equal true, ConnectFour.is_valid_move(board, 1)
    assert_equal false, ConnectFour.is_valid_move(board, 2)
  end
  def test_make_move
    board = Array.new(8) { Array.new(8, ".") }
    assert_equal "x", ConnectFour.make_move(board, 1, "x")
  end
end
