require 'test_helper'
require "minitest/autorun"
include ConnectFour

class ConnectFourTest < ConnectFourSpec

  describe CLI do
    it "prints start screen" do
      input = StringIO.new "Kevin red x\nSchmevin blue o\n"
      output = StringIO.new
      cli = CLI.new input, output
      cli.start_screen

      assumed_output = <<~END
        Welcome to Connect Four!
        Who wants to play? (name color piece)
        Player 1: Player 2: Enter \e[1m\e[3mexit\e[0m or \e[1m\e[3mquit\e[0m to leave.
      END

      assert_equal assumed_output, output.string
    end

    it "reads player input" do
      input = StringIO.new "Kevin red x\nSchmevin blue o\n"
      output = StringIO.new
      cli = CLI.new input, output 
      output = cli.start_screen

      assumed_output = [["Kevin","\e[31mx\e[0m"],["Schmevin","\e[34mo\e[0m"]]

      assert_equal assumed_output, output
    end
  end
  
  def setup
    @cli = ConnectFour::CLI.new
    @board = ConnectFour::Board.new
    @test = (1..8).inject([]) {|a,i| a << []}
    @player1 = ConnectFour::Player.new("Kevin", "x")
    @player2 = ConnectFour::Player.new("Schmevin", "o")
    @game = ConnectFour::Game.new @cli, @board, @player1, @player2
  end

  def test_version
    assert ConnectFour::VERSION
  end
  
  def test_win
    populate_board [
      [1, "x", 1],
      [2, "x", 2],
      [3, "x", 3],
      [3, "o", 4],
      [1, "x", 4]
    ]
    assert @game.won?
  end

  private

  def populate_board(ary)
    ary.each do |times, piece, column|
      times.times {@board.put_piece piece, column}
    end
  end
end
