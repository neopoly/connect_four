require 'test_helper'
require "minitest/autorun"

class ConnectFourTest < ConnectFourSpec

  describe CLI do
    it "reads input" do
      input = StringIO.new("test 1 2 3")
      cli = CLI.new(input, nil)

      value = cli.readInput

      expect("test 1 2 3").must_equal value
    end
    it "prints to stdout" do
      output = StringIO.new
      cli = CLI.new(nil, output)

      cli.printOut("test 1 2 3")

      expect("test 1 2 3").must_equal output.string
    end
  end
  
  def setup
    @board = ConnectFour::Board.new
    @test = (1..8).inject([]) {|a,i| a << []}
    @player1 = ConnectFour::Player.new("Kevin", "x")
    @player2 = ConnectFour::Player.new("Schmevin", "o")
    @game = ConnectFour::Game.new @board, @player1, @player2
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
