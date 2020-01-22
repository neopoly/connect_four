require "test_helper"
require "minitest/autorun"
include ConnectFour

class ConnectFourTest < ConnectFourSpec
  describe CLI do
    before do
      @input = StringIO.new "Kevin red x\nSchmevin blue o\n"
      @output = StringIO.new
      @cli = CLI.new @input, @output
      @board = Board.new 8, 8
      @player1 = Player.new("Kevin", "x")
      @player2 = Player.new("Schmevin", "o")
      @game = Game.new @cli, @board, @player1, @player2
    end

    it "prints start screen" do
      @cli.start_screen

      assumed_output = <<~END
        Welcome to Connect Four!
        Who wants to play? (name color piece)
        Player 1: Player 2: Enter \e[1m\e[3mexit\e[0m or \e[1m\e[3mquit\e[0m to leave.

      END

      assert_equal assumed_output, @output.string
    end

    it "reads starting input" do
      output = @cli.start_screen

      assumed_output = [["Kevin", "\e[31mx\e[0m"], ["Schmevin", "\e[34mo\e[0m"]]

      assert_equal assumed_output, output
    end

    it "draws the interface" do
      @cli.draw_interface @game.game_state

      assumed_output = <<~END.chomp
        1|2|3|4|5|6|7|8
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.
        .|.|.|.|.|.|.|.


        \e[K\e[1F\e[KKevin (x):\x20
      END

      assert_equal assumed_output, @output.string
    end
  end

  describe Game do
    before do
      @input = StringIO.new "Kevin red x\nSchmevin blue o\n"
      @output = StringIO.new
      @cli = CLI.new @input, @output
      @board = Board.new
      @player1 = Player.new("Kevin", "x")
      @player2 = Player.new("Schmevin", "o")
      @game = Game.new @cli, @board, @player1, @player2
    end

    it "checks win conditions" do
      populate_board [
        [1, "x", 1],
        [2, "x", 2],
        [3, "x", 3],
        [3, "o", 4],
        [1, "x", 4],
      ]

      assert @game.won?

      setup

      populate_board [
        [4, "x", 4],
      ]

      assert @game.won?

      setup

      populate_board (1..4).map { |i| [1, "x", i] }

      assert @game.won?

      # negative tests
      setup

      refute @game.won?

      populate_board (1..3).map { |i| [3, "x", i] }

      refute @game.won?
    end

    private

    def populate_board(ary)
      ary.each do |times, piece, column|
        times.times { @board.put_piece piece, column }
      end
    end
  end
end
