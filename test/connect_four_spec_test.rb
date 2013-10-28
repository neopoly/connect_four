require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'connect_four'

class ConnectFourSpec < Minitest::Test

	describe ConnectFour do
    	
    	before do
      		@connect_four = ConnectFour.new 7, 6, 4
    	end

    	describe "when initializing" do
      		it "must create player" do
        		@connect_four.player.must_be_instance_of Player
      		end
      		
      		it "must create player o" do
        		@connect_four.playero.must_be_instance_of Player
      		end

      		it "must create player x" do
        		@connect_four.playerx.must_be_instance_of Player
      		end
      		
      		it "must show rules" do
        		@connect_four.show_rules.must_equal 'CONNECT FOUR'
      		end
      		
      		it "must create a board" do
        		@connect_four.board.must_be_instance_of Board
      		end
    	end

	   	describe "when player" do
    		it "plays" do
    			describe "when player is player o" do
    				before do
    					@connect_four = ConnectFour.new 7, 6, 4
    					@connect_four.player = @connect_four.playero
    				end
    		
    				it "toggles the player to player x" do
    					@connect_four.toggle_player.must_equal @connect_four.playerx
    				end
    			
    				it "wont toggle the player to player o" do
    					@connect_four.toggle_player.wont_equal @connect_four.playero
    				end
    			
      				it "prompts for column number between 1-7" do
        				#@connect_four.play.
      				end
      			end
      		end
    	end
	end
end
