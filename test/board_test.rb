require 'test_helper'

class BoardTest < ConnectFourSpec
  def test_is_valid_move_returns_a_value
    game_board = Board.new
    assert game_board.is_valid_move?(1) != nil
  end

  def test_is_valid_move_returns_a_boolean
    game_board = Board.new
    assert game_board.is_valid_move?(1).is_a?(TrueClass) || game_board.is_valid_move?(1).is_a?(FalseClass) 
  end

  def test_is_valid_move_returns_false_if_invalid
    game_board = Board.new
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    assert_equal false, game_board.is_valid_move?(1)
  end

   def test_is_valid_move_returns_true_if_valid
    game_board = Board.new
    assert_equal true, game_board.is_valid_move?(1)
  end

  def test_raises_error_when_input_invalid
    assert_raises "Wrong input." do
      game_board = Board.new
      game_board.is_valid_move?("x")
    end
  end

  def test_raises_error_when_out_of_bounds
    assert_raises "Wrong input." do
      game_board = Board.new
      game_board.is_valid_move?(9)
    end
  end

  def test_make_move_returns_a_value
    game_board = Board.new
    assert game_board.make_move(1, "x") != nil
  end

  def test_make_move_returns_a_boolean
    game_board = Board.new
    assert game_board.make_move(1, "x").is_a?(TrueClass) || board.make_move(1, "x").is_a?(FalseClass) 
  end

  def test_raises_error_when_token_not_string
    assert_raises "Token has invalid format." do
      game_board = Board.new
      game_board.make_move(1, 34)
    end
  end

  def test_raises_error_when_token_too_long
    assert_raises "Token has invalid format." do
      game_board = Board.new
      game_board.make_move(1, "No")
    end
  end
end
