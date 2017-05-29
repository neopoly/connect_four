require 'test_helper'

class GameTest < ConnectFourSpec
  def test_make_move_player1_returns_a_value
    game = Game.new
    assert game.make_move_player1(1) != nil
  end

  def test_make_move_player1_returns_a_boolean
    game = Game.new
    assert game.make_move_player1(1).is_a?(TrueClass) || game.make_move_player1(1).is_a?(FalseClass) 
  end

  def test_make_move_player2_returns_a_value
    game = Game.new
    assert game.make_move_player2(1) != nil
  end

  def test_make_move_player2_returns_a_boolean
    game = Game.new
    assert game.make_move_player2(1).is_a?(TrueClass) || game.make_move_player2(1).is_a?(FalseClass) 
  end

  def test_move_player1_raises_error_when_out_of_bounds
    assert_raises "Wrong input." do
      game = Game.new
      game.make_move_player1(9)
    end
  end

  def test_move_player2_raises_error_when_out_of_bounds
    assert_raises "Wrong input." do
      game = Game.new
      game.make_move_player2(9)
    end
  end
end
