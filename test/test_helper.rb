require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'connect_four'

class ConnectFourSpec < Minitest::Test

	describe ConnectFour do
    	before do
      		@connect_four = ConnectFour.new 7,6
    	end

    	describe "when initializing" do
      		it "must create player o" do
        		@connect_four.playero.must_be_instance_of Player
      		end
      		
      		it "must create player x" do
        		@connect_four.playerx.must_be_instance_of Player
      		end
      		
      		it "must show rules" do
        		@connect_four.show_rules.must_equal 'Rules'
      		end
      		
      		it "must create a grid" do
        		@connect_four.grid.length.must_be_instance_of Grid
      		end
    	end
    	
    	describe "when playing" do
    		it "toggles players each turn" do
    			if @connect_four.player === @connect_four.playero
    				@connect_four.toggle_player.must_equal @connect_four.playerx
    			elsif @connect_four.player === @connect_four.playerx
    				@connect_four.toggle_player.must_equal @connect_four.playero
    				
    			end
    		end
      		it "prompts for column number between 1-7" do
        		#@connect_four.play.
      		end
    	end
	end

end
