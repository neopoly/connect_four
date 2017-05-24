require 'test_helper'
require 'game/board'

class BoardTest < ConnectFourTestHelper
  def test_new_board
    expected_output = ""
    8.times do
      expected_output << "........\n"
    end

    assert_equal Board.new(8,8).to_s,expected_output
  end
end

