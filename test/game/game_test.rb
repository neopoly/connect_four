require 'test_helper'
require 'game/connect_four_game'

class GameTest < ConnectFourTestHelper

  def setup
    @game = ConnectFourGame.new
  end

  def test_new_game
    assert_equal 'new', @game.state

    @game.start
    assert_equal 'player_1_move', @game.state
    @game.make_move 4
    assert_equal 'player_2_move', @game.state
    @game.make_move 7
    assert_equal 'player_1_move', @game.state
  end
end