require "test_helper"
include ConnectFour

class ConnectFourTest < ConnectFourSpec
  describe CLI do
    before do
      @input = StringIO.new "Kevin red x\nSchmevin blue o\n"
      @output = StringIO.new
      @cli = CLI.new @input, @output
      players = [["Kevin", "x"], ["Schmevin", "o"]]
      @game = Game.new players
    end

    it "prints start screen" do
      @cli.welcome
      @cli.ask_for_player_data
      @cli.exit_info

      assumed_output = <<~END
        Welcome to Connect Four!
        Who wants to play? (name color piece)
        Player 1: Player 2: Enter \e[1m\e[3mexit\e[0m or \e[1m\e[3mquit\e[0m to leave.

      END

      assert_equal assumed_output, @output.string
    end

    it "reads starting input" do
      output = @cli.ask_for_player_data

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
end
