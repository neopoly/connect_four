require 'test_helper'
require 'stringio'

class GameTest < ConnectFourSpec
  def test_make_move_player1_returns_a_value
    game = Game.new
    refute_nil game.make_move_player1(1)
  end

  def test_make_move_player1_returns_a_boolean
    game = Game.new
    assert game.make_move_player1(1).is_a?(TrueClass) || game.make_move_player1(1).is_a?(FalseClass) 
  end

  def test_make_move_player2_returns_a_value
    game = Game.new
    refute_nil game.make_move_player2(1)
  end

  def test_make_move_player2_returns_a_boolean
    game = Game.new
    assert game.make_move_player2(1).is_a?(TrueClass) || game.make_move_player2(1).is_a?(FalseClass) 
  end

  def test_move_player1_raises_error_when_out_of_bounds
    e = assert_raises RuntimeError do
      game = Game.new
      game.make_move_player1(9)
    end
    assert_equal "Wrong input.", e.message
  end

  def test_move_player2_raises_error_when_out_of_bounds
    e = assert_raises RuntimeError do
      game = Game.new
      game.make_move_player2(9)
    end
    assert_equal "Wrong input.", e.message
  end
  
  def test_did_player1_win_raises_error_when_token_not_last
    e = assert_raises RuntimeError do
      game = Game.new
      game.did_player1_win?(1)
    end
    assert_equal "Token not in expected position.", e.message
  end

  def test_did_player1_win_returns_true_when_four_connected
    game = Game.new
    game.make_move_player1(1)
    game.make_move_player1(1)
    game.make_move_player1(1)
    game.make_move_player1(1)
    assert_equal true, game.did_player1_win?(1)
  end

  def test_did_player1_win_returns_false_when_not_four_connected
    game = Game.new
    game.make_move_player1(1)
    assert_equal false, game.did_player1_win?(1)
  end
  
  def test_did_player2_win_raises_error_when_token_not_last
    e = assert_raises RuntimeError do
      game = Game.new
      game.did_player2_win?(1)
    end
    assert_equal "Token not in expected position.", e.message
  end

  def test_did_player2_win_returns_true_when_four_connected
    game = Game.new
    game.make_move_player2(1)
    game.make_move_player2(1)
    game.make_move_player2(1)
    game.make_move_player2(1)
    assert_equal true, game.did_player2_win?(1)
  end

  def test_did_player2_win_returns_false_when_not_four_connected
    game = Game.new
    game.make_move_player2(1)
    assert_equal false, game.did_player2_win?(1)
  end  

  def test_get_valid_move_only_accepts_valid_input
    valid_inputs = [1, 2, 3, 4, 5, 6, 7, 8]
    invalid_inputs = ["a", "b", "c", "d", "e", "f", "g", "h", 9, 10, 11, 12, 13, 14, 15, 16]
    input = StringIO.new
    output = StringIO.new

    input.puts "#{invalid_inputs.sample}" 
    input.puts "#{valid_inputs.sample}"
    input.rewind   

    game = Game.new(input, output)
    assert_includes valid_inputs, game.get_valid_move_pos("Player 1")
  end

  def test_play_returns_1_if_player1_wins
    input = StringIO.new
    output = StringIO.new

    input.puts "1"
    input.puts "1"
    input.puts "2"
    input.puts "2"
    input.puts "3"
    input.puts "3"
    input.puts "4"
    input.puts "4"
    input.rewind

    game = Game.new(input, output)
    assert_equal 1, game.play
  end 
  
  def test_play_returns_2_if_player2_wins
    input = StringIO.new
    output = StringIO.new

    input.puts "1"
    input.puts "2"
    input.puts "2"
    input.puts "3"
    input.puts "3"
    input.puts "4"
    input.puts "4"
    input.puts "5"
    input.rewind

    game = Game.new(input, output)
    assert_equal 2, game.play
  end
  
  def test_play_returns_0_if_draw
    input = StringIO.new
    output = StringIO.new

    input.puts "1"
    input.puts "3"
    input.puts "2"
    input.puts "4"
    input.puts "5"
    input.puts "7"
    input.puts "6"
    input.puts "8"
    
    input.puts "3"
    input.puts "1"
    input.puts "4"
    input.puts "2"
    input.puts "7"
    input.puts "5"
    input.puts "8"
    input.puts "6"
    
    input.puts "1"
    input.puts "3"
    input.puts "2"
    input.puts "4"
    input.puts "5"
    input.puts "7"
    input.puts "6"
    input.puts "8"

    input.puts "3"
    input.puts "1"
    input.puts "4"
    input.puts "2"
    input.puts "7"
    input.puts "5"
    input.puts "8"
    input.puts "6"

    input.puts "1"
    input.puts "3"
    input.puts "2"
    input.puts "4"
    input.puts "5"
    input.puts "7"
    input.puts "6"
    input.puts "8"
    
    input.puts "3"
    input.puts "1"
    input.puts "4"
    input.puts "2"
    input.puts "7"
    input.puts "5"
    input.puts "8"
    input.puts "6"
    
    input.puts "1"
    input.puts "3"
    input.puts "2"
    input.puts "4"
    input.puts "5"
    input.puts "7"
    input.puts "6"
    input.puts "8"

    input.puts "3"
    input.puts "1"
    input.puts "4"
    input.puts "2"
    input.puts "7"
    input.puts "5"
    input.puts "8"
    input.puts "6"
    input.rewind

    game = Game.new(input, output)
    assert_equal 0, game.play
  end
end
