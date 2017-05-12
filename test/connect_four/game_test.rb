require 'test_helper'

class ConnectFour::GameTest < ConnectFourSpec
  describe ConnectFour::Game do
    let(:game) { ConnectFour::Game.new }

    it "should respond to board" do
      game.must_respond_to :board
    end
  end
end
