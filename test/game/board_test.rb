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

    #diagonal
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
                               %w[. . x . o . . .],
                               %w[. . o x x o . .],
                               %w[. . x o x o . .],
                               %w[. x o x o x o .]]

    assert test_board.win_condition_met?


    #vertical
    test_board.fields = Matrix[%w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . x . .],
                               %w[. . o . . x . .],
                               %w[. . o . . x . .],
                               %w[. . o . . x . .]]

    assert test_board.win_condition_met?

    #horizontal
    test_board.fields = Matrix[%w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . o o o . . .],
                               %w[. . x x x x . .]]

    assert test_board.win_condition_met?

    #negative sparse
    test_board.fields = Matrix[%w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[. . . . o . . .],
                               %w[. . o x x o . .],
                               %w[. . x o x o . .],
                               %w[. x o x o x o .]]

    assert !test_board.win_condition_met?

    #negative test full
    test_board.fields = Matrix[%w[. . . . . . . .],
                               %w[. . . . . . . .],
                               %w[x x o x o x o o],
                               %w[o o o x o x x x],
                               %w[x x x o x o o o],
                               %w[x o o x o x o x],
                               %w[o x o x o x o x],
                               %w[x o x o x o x o]]

    assert !test_board.win_condition_met?
  end

end

