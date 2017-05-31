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
  
  def test_did_player1_win_raises_error_when_token_not_last
    assert_raises "Token not in expected position" do
      game = Game.new
      game.did_player1_win?(1)
    end
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
    assert_raises "Token not in expected position" do
      game = Game.new
      game.did_player2_win?(1)
    end
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

  def test_get_move_returns_valid_integer
    valid_integers = [1, 2, 3, 4, 5, 6, 7, 8]
    sample_inputs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    with_stdin do |user_input|
      user_input.puts "#{valid_integers.sample}"
      game = Game.new
      assert_includes valid_integers, game.get_move_pos("Player 1")
    end
  end

  def with_stdin
    stdin = $stdin             # remember $stdin
    $stdin, write = IO.pipe    # create pipe assigning its "read end" to $stdin
    yield write                # pass pipe's "write end" to block
  ensure
    write.close                # close pipe
    $stdin = stdin             # restore $stdin
  end
end
