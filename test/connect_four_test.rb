require 'test_helper'

class ConnectFourTest < ConnectFourSpec

  #####################################
  # Test of Gameboard
  #####################################
  def test_init_board
    board = [[".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", ".", ".", "."]]

    assert_equal board, ConnectFour::GameBoard.new.board

    board = [[".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."],
             [".", ".", ".", ".", "."]]

    assert_equal board, ConnectFour::GameBoard.new(dim=5).board
  end
  def test_put_mark
    game_board = ConnectFour::GameBoard.new
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
    game_board = ConnectFour::GameBoard.new
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 1)
    game_board.put_mark('x', 2)
    game_board.put_mark('x', 3)
    assert (not game_board.full_board?)
    assert game_board.connect_row?
  end

  def test_connect_col
    game_board = ConnectFour::GameBoard.new
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 0)
    game_board.put_mark('x', 0)
    assert game_board.connect_col?
  end

  def test_connect_diag
    game_board = ConnectFour::GameBoard.new
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
  end

  def test_full_board
    game_board = ConnectFour::GameBoard.new
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

    assert (not game_board.connect_row?)
    assert (not game_board.connect_col?)
    assert (not game_board.connect_diag?)
    assert game_board.full_board?
  end

  #####################################
  # Test of Game
  #####################################
  def test_init_board_by_new_game
    board = ConnectFour::GameBoard.new.board
    assert_equal board, ConnectFour::Game.new.game_board.board
  end

  def test_check_turn
    game = ConnectFour::Game.new
    assert_equal 1, game.player
    game.switch_turn
    assert_equal 2, game.player

    game = ConnectFour::Game.new(dim=8, player=2)
    assert_equal 2, game.player
  end

  def test_game_over_by_connecting_row
    game = ConnectFour::Game.new
    game.game_board.put_mark('x', 0)
    game.game_board.put_mark('x', 1)
    game.game_board.put_mark('x', 2)
    game.game_board.put_mark('x', 3)
    assert game.game_board.connect_row?
    assert game.game_over?
  end

  def test_game_over_by_connecting_col
    game = ConnectFour::Game.new
    game.game_board.put_mark('x', 0)
    game.game_board.put_mark('x', 0)
    game.game_board.put_mark('x', 0)
    game.game_board.put_mark('x', 0)
    assert game.game_board.connect_col?
    assert game.game_over?
  end

  def test_game_over_by_connecting_diag
    game = ConnectFour::Game.new
    game.game_board.put_mark('x', 0)
    game.game_board.put_mark('o', 1)
    game.game_board.put_mark('x', 1)
    game.game_board.put_mark('o', 2)
    game.game_board.put_mark('o', 2)
    game.game_board.put_mark('x', 2)
    game.game_board.put_mark('o', 3)
    game.game_board.put_mark('o', 3)
    game.game_board.put_mark('o', 3)
    game.game_board.put_mark('x', 3)
    assert game.game_board.connect_diag?
    assert game.game_over?
  end

  def test_game_over_by_full_board
    game = ConnectFour::Game.new
    for row in 0..7
      for col in (0..7).step(4)
        if row % 2 == 0
          game.game_board.put_mark('x', col)
          game.game_board.put_mark('x', col+1)
          game.game_board.put_mark('o', col+2)
          game.game_board.put_mark('o', col+3)
        else
          game.game_board.put_mark('o', col)
          game.game_board.put_mark('o', col+1)
          game.game_board.put_mark('x', col+2)
          game.game_board.put_mark('x', col+3)
        end
      end
    end
    assert game.game_board.full_board?
    assert game.game_over?
  end

  def test_check_winner
    game = ConnectFour::Game.new
    6.times do
      # player 1
      if game.player == 1
        game.game_board.put_mark('x', 0)
        game.switch_turn
      # player 2
      elsif game.player == 2
        game.game_board.put_mark('o', 1)
        game.switch_turn
      end
    end
    game.game_board.put_mark('x', 0)
    assert game.game_over?
    assert game.check_winner == 1
  end
end
