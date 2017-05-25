require 'test_helper'
require 'game/board'
require 'matrix'

class BoardTest < ConnectFourTestHelper
  def test_new_board
    expected_output = ""
    8.times do
      expected_output << "........\n"
    end

    assert_equal Board.new(8, 8, 4).to_s, expected_output
  end

  def test_solver


    test_board = Board.new(8, 8, 4)

    test_board.fields = Matrix[%w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . x . . .],
                               %w[. . o x x o . .],
                               %w[. . x o x o . .],
                               %w[. x o x o x o .]]

    assert test_board.win_condition_met?

    test_board.fields = Matrix[%w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . o . . .],
                               %w[. . o x x o . .],
                               %w[. . x o x o . .],
                               %w[. x o x o x o .]]

    assert !test_board.win_condition_met?
  end

end

