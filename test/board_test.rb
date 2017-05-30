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

  def test_make_move_raises_error_when_token_not_valid
    assert_raises "Token is invalid." do
      game_board = Board.new
      game_board.make_move(1, 34)
    end
  end

  def test_are_four_connected_raises_error_when_token_not_valid
    assert_raises "Token is invalid." do
      game_board = Board.new
      game_board.are_four_connected?(1, "p")
    end
  end

  def test_are_four_connected_raises_error_when_token_not_last
    assert_raises "Token not in expected position." do
      game_board = Board.new
      game_board.are_four_connected?(1, "x")
    end
  end

  def test_are_four_connected_returns_true_if_connected
    game_board = Board.new
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(1, "x")
    game_board.make_move(2, "x")
    game_board.make_move(3, "x")
    game_board.make_move(4, "x")
    game_board.make_move(2, "o")
    game_board.make_move(2, "x")
    game_board.make_move(3, "x")
    game_board.make_move(5, "o")
    game_board.make_move(5, "x")
    game_board.make_move(6, "o")
    game_board.make_move(6, "o")
    game_board.make_move(6, "x")
    game_board.make_move(7, "o")
    game_board.make_move(7, "o")
    game_board.make_move(7, "o")
    game_board.make_move(7, "x")
    assert_equal true, game_board.are_four_connected?(1, "x")
    assert_equal true, game_board.are_four_connected?(2, "x")
    assert_equal true, game_board.are_four_connected?(4, "x")
    assert_equal true, game_board.are_four_connected?(7, "x")
  end

  def test_are_four_connected_returns_false_if_not_connected
    game_board = Board.new
    game_board.make_move(1, "x")
    assert_equal false, game_board.are_four_connected?(1, "x")
  end
end
