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
  end
end
