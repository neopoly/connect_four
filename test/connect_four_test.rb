require 'test_helper'

class ConnectFourTest < ConnectFourSpec
  def test_hello_world
    assert_equal "hello world", ConnectFour.hello_world
  end
  def test_reset_board
    board = Array.new(8) { Array.new(8, ".") }
    assert_equal board, ConnectFour.reset_board(board)
  end
end
