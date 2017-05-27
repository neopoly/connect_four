require 'test_helper'
require 'connect_four'


describe "checks if a normal game runs through" do
  before do
    class ConnectFour
      @test_inputs = %w[y 1 2 3 4 1 2 3 4 1 2 3 4 1 n]

      def self.read_input
        if @test_inputs.size > 0
          val = @test_inputs.shift
          puts val
          return val
        else
          raise 'TestCase pulls more values than expected'
        end
      end
    end
  end

  it "should play the game" do
    game = ConnectFour.main
  end
end
