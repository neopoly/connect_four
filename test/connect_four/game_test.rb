require 'test_helper'

class ConnectFour::GameTest < ConnectFourSpec
  describe ConnectFour::Game do
    let(:game) { ConnectFour::Game.new }

    it "should respond to board" do
      game.must_respond_to :board
    end

    describe "#display_board" do
      it "should display the board on the terminal" do
        proc { game.display_board }.must_output game.board.stringified
      end
    end

    describe "#prompt_for_input" do
      it "should output player x > for x" do
        proc { game.prompt_for_input "x" }.must_output "player x >"
      end
    end
  end
end
