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

    board = [[".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."]]

    assert_equal board, ConnectFour.init_board(dim=5)
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
    assert ConnectFour.put_mark('x',col)
    assert_equal board, ConnectFour.current_board

    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             ["o", ".", ".", ".", ".", ".", ".", "."],
             ["x", ".", ".", ".", ".", ".", ".", "."]]
    assert ConnectFour.put_mark('o',col)
    assert_equal board, ConnectFour.current_board
  end

  # Test for switching players and check the turn
  def test_check_turn
    ConnectFour.init_board
    assert_equal 1, ConnectFour.check_turn
    ConnectFour.put_mark('x', 0)
    ConnectFour.switch_turn
    assert_equal 2, ConnectFour.check_turn

    ConnectFour.init_board(dim=8, player=2)
    assert_equal 2, ConnectFour.check_turn

  end

  # Test for game over and connection
  def test_connect_row
    ConnectFour.init_board
    ConnectFour.put_mark('x', 0)
    ConnectFour.put_mark('x', 1)
    ConnectFour.put_mark('x', 2)
    ConnectFour.put_mark('x', 3)
    assert (not ConnectFour.full_board?)
    assert ConnectFour.connect_row?
    assert ConnectFour.game_over?
  end

  def test_connect_col
    ConnectFour.init_board
    ConnectFour.put_mark('x', 0)
    ConnectFour.put_mark('x', 0)
    ConnectFour.put_mark('x', 0)
    ConnectFour.put_mark('x', 0)
    assert ConnectFour.connect_col?
    assert ConnectFour.game_over?
  end

  def test_connect_diag
    ConnectFour.init_board
    ConnectFour.put_mark('x', 0)
    ConnectFour.put_mark('o', 1)
    ConnectFour.put_mark('x', 1)
    ConnectFour.put_mark('o', 2)
    ConnectFour.put_mark('o', 2)
    ConnectFour.put_mark('x', 2)
    ConnectFour.put_mark('o', 3)
    ConnectFour.put_mark('o', 3)
    ConnectFour.put_mark('o', 3)
    ConnectFour.put_mark('x', 3)
    assert ConnectFour.connect_diag?
    assert ConnectFour.game_over?
  end

  def test_full_board
    ConnectFour.init_board
    # fill the board
    for col in (0..7).step(4)
      for row in 0..7
        if ConnectFour.check_turn == 1
          ConnectFour.put_mark('x', col)
          ConnectFour.put_mark('x', col+1)
          ConnectFour.put_mark('o', col+2)
          ConnectFour.put_mark('o', col+3)
          ConnectFour.switch_turn
        else
          ConnectFour.put_mark('o', col)
          ConnectFour.put_mark('o', col+1)
          ConnectFour.put_mark('x', col+2)
          ConnectFour.put_mark('x', col+3)
          ConnectFour.switch_turn
        end
      end
    end

    assert (not ConnectFour.connect_row?)
    assert (not ConnectFour.connect_col?)
    assert (not ConnectFour.connect_diag?)
    assert ConnectFour.full_board?
    assert ConnectFour.game_over?
  end

  # check winner
  def test_check_winner
    ConnectFour.init_board
    6.times do
      # player 1
      if ConnectFour.check_turn == 1
        if ConnectFour.put_mark('x', 0)
          ConnectFour.switch_turn
        end
      # player 2
      elsif ConnectFour.check_turn == 2
        if ConnectFour.put_mark('o', 1)
          ConnectFour.switch_turn
        end
      end
    end

    if ConnectFour.put_mark('x', 0)
      assert ConnectFour.game_over?
      assert ConnectFour.check_winner == 1
    end

  end
end
