require 'test_helper'
require 'game/connect_four_game'

class GameTest < ConnectFourTestHelper
  def test_new_game
    assert_equal "new", ConnectFourGame.new.state
  end
end