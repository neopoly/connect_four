require 'test_helper'

class GameBoardTest < ConnectFourSpec
  def test_init_board
    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."]]

    assert_equal board, GameBoard.new.board

    board = [[".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."]]

    assert_equal board, GameBoard.new(dim=5).board
  end
  def test_put_mark
    game_board = GameBoard.new
    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             ["x", ".", ".", ".", ".", ".", ".", "."]]
    col = 0

    assert game_board.put_mark('x',col)
    assert_equal board, game_board.board

    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             ["o", ".", ".", ".", ".", ".", ".", "."],
             ["x", ".", ".", ".", ".", ".", ".", "."]]
    assert game_board.put_mark('o',col)
    assert_equal board, game_board.board
  end

  # Test for game over and connection
  def test_connect_row
    game_board = GameBoard.new
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 1)
    game_board.put_mark('x', 2)
    game_board.put_mark('x', 3)
    assert (not game_board.full_board?)
    assert game_board.connect_row?
    assert game_board.game_over?
  end

  def test_connect_col
    game_board = GameBoard.new
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 0)
    assert game_board.connect_col?
    assert game_board.game_over?
  end

  def test_connect_diag
    game_board = GameBoard.new
    game_board.put_mark('x', 0)
    game_board.put_mark('o', 1)
    game_board.put_mark('x', 1)
    game_board.put_mark('o', 2)
    game_board.put_mark('o', 2)
    game_board.put_mark('x', 2)
    game_board.put_mark('o', 3)
    game_board.put_mark('o', 3)
    game_board.put_mark('o', 3)
    game_board.put_mark('x', 3)
    assert game_board.connect_diag?
    assert game_board.game_over?
  end

  def test_full_board
    game_board = GameBoard.new
    # fill the board
    for row in 0..7
      for col in (0..7).step(4)
        if row % 2 == 0
          game_board.put_mark('x', col)
          game_board.put_mark('x', col+1)
          game_board.put_mark('o', col+2)
          game_board.put_mark('o', col+3)
        else
          game_board.put_mark('o', col)
          game_board.put_mark('o', col+1)
          game_board.put_mark('x', col+2)
          game_board.put_mark('x', col+3)
        end
      end
    end

    refute game_board.connect_row?
    refute game_board.connect_col?
    refute game_board.connect_diag?
    assert game_board.full_board?
  end
end
