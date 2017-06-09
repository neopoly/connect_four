require 'test_helper'
require 'connect_four'


describe "checks if a normal game runs through" do
  before do
    class ConnectFour
      @test_inputs = %w[y 1 2 3 4 1 2 3 4 1 2 3 4 1 n]
      @output_buffer = ""

      def self.read_input
        if @test_inputs.size > 0
          val = @test_inputs.shift
          write_output val
          return val
        else
          raise 'TestCase pulls more values than expected'
        end
      end
      def self.write_output(text)
        @output_buffer << text
      end
    end
  end

  it "should play the game" do
    ConnectFour.main
  end
end
