require 'test_helper'
require "minitest/autorun"

class ConnectFourTest < ConnectFourSpec
  
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
