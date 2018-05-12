require 'test_helper'
require 'stringio'

class GameTest < ConnectFourSpec
  def test_init_board_by_new_game
    board = GameBoard.new.board
    assert_equal board, Game.new.game_board.board
  end

  def test_check_turn
    game = Game.new
    assert_equal 1, game.player
    game.switch_turn
    assert_equal 2, game.player

    game = Game.new(dim=8, player=2)
    assert_equal 2, game.player
  end

  def test_check_winner
    game = Game.new
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
    assert game.game_board.game_over?
    assert game.check_winner == 1
  end
  def test_input_normal
    game = Game.new
    $stdin = StringIO.new("1\n")
    assert_equal 0, game.get_input
  end

  def test_input_out_of_range
    game = Game.new
    $stdin = StringIO.new("10\n")
    refute game.get_input
  end

  def test_input_not_int
    game = Game.new
    $stdin = StringIO.new("a\n")
    refute game.get_input
  end

end
