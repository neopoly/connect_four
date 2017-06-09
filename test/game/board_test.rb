require 'test_helper'
require 'game/board'

class BoardTest < ConnectFourTestHelper

  def setup
    @test_board = Board.new(8, 8, 4)
  end

  def test_new_board
    expected_output = ""
    8.times do
      expected_output << "........\n"
    end

    assert_equal @test_board.to_s, expected_output
  end

  def test_solver
    #diagonal
    @test_board.fill [%w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . x . . .],
                                %w[. . o x x o . .],
                                %w[. . x o x o . .],
                                %w[. x o x o x o .]]

    assert @test_board.win_condition_met?

    @test_board.fill [%w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . x . o . . .],
                                %w[. . o x x o . .],
                                %w[. . x o x o . .],
                                %w[. x o x o x o .]]

    assert @test_board.win_condition_met?


    # vertical
    @test_board.fill [%w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . x . .],
                                %w[. . o . . x . .],
                                %w[. . o . . x . .],
                                %w[. . o . . x . .]]

    assert @test_board.win_condition_met?

    # horizontal
    @test_board.fill [%w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . o o o . . .],
                                %w[. . x x x x . .]]

    assert @test_board.win_condition_met?

    # negative sparse
    @test_board.fill [%w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . . . . .],
                                %w[. . . . o . . .],
                                %w[. . o x x o . .],
                                %w[. . x o x o . .],
                                %w[. x o x o x o .]]

    assert !@test_board.win_condition_met?
    assert !@test_board.full?

    # negative test full
    @test_board.fill [%w[o o x o x o x x],
                                %w[o o x o x o x x],
                                %w[x x o x o x o o],
                                %w[o o o x o x x x],
                                %w[x x x o x o o o],
                                %w[x o o x o x o x],
                                %w[o x o x o x o x],
                                %w[x o x o x o x o]]

    assert !@test_board.win_condition_met?
    assert @test_board.full?
  end

  def test_insert
    expected_output = ""
    7.times do
      expected_output << "........\n"
    end
    expected_output << ".......x\n"

    @test_board.insert_char_at 'x', 8

    assert_equal @test_board.to_s, expected_output

    error = assert_raises RuntimeError do
      @test_board.insert_char_at 'F', -2
    end

    assert_match(/Invalid/, error.message)

    7.times do
      @test_board.insert_char_at 'x', 8
    end

    error = assert_raises RuntimeError do
      @test_board.insert_char_at 'x', 8
    end

    assert_match(/Full/i, error.message)
  end

end

