require 'test_helper'

class ConnectFourTest < ConnectFourSpec
  def test_hello_world
    assert_equal "hello world", ConnectFour.hello_world
  end

  # Test for initialize and put the mark
  def test_init_board
    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."]]

    assert_equal board, ConnectFour.init_board
  end

  def test_put_mark
    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             ["x", ".", ".", ".", ".", ".", ".", "."]]
    col = 0
    ConnectFour.init_board
    assert_equal board, ConnectFour.put_mark('x',col)

    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             ["o", ".", ".", ".", ".", ".", ".", "."],
             ["x", ".", ".", ".", ".", ".", ".", "."]]
    assert_equal board, ConnectFour.put_mark('o',col)
  end

  # Test for switching players and check the turn
  def test_check_turn
    ConnectFour.init_board(player=1)
    assert_equal 1, ConnectFour.check_turn
    ConnectFour.put_mark('x', 0)
    assert_equal 2, ConnectFour.check_turn
  end

end
