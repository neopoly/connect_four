require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'connect_four'

class ConnectFourSpec < Minitest::Test
	parallelize_me!
	
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

		describe "when game starts" do
			it "must be player o who plays" do
				@connect_four.player.must_equal @connect_four.playero
			end
			it "wont be player x who plays" do
				@connect_four.player.wont_equal @connect_four.playerx
			end
			it "has an empty board" do
				for column in 0...7
					for row in 0...6
						#@connect_four.board.tilemap[column][row].color.wont_include @connect_four.playero.color or @connect_four.playerx.color
					end
				end
			end
		end

	   	describe "when player o is playing" do
    		it "asks player to drop disc in a column" do
    			@connect_four.ask_player_to_drop_disc_in_a_column.must_be_within_delta 0,6  			
      		end
    	end
    	
    	describe "when player enters a column number" do
      		it "checks if column is out of range" do
    			@connect_four.check_that_column_is_in_range(9).must_equal false 			
      		end
       		it "checks if number is between 1 and 7" do
    			@connect_four.is_in_range?(9).must_equal false
    		end
    		it "shows an error when column is out of range" do
    			Proc.new{@connect_four.play_turn(9)}.must_output "Position is out of range [1-7]. Play again!\n" 			
      		end
    	end

    	describe "when player entered a valid column" do
    	    it "drops disc to column in board" do
    			@connect_four.player.drops_disc_to_column_in_board(4, @connect_four.board).must_equal :player_has_played
    		end
    		
    		it "checks if player has no connections yet" do
    			@connect_four.player.drops_disc_to_column_in_board(4, @connect_four.board).wont_equal :player_has_won
    		end
    		   		
    		it "checks if player has won" do
    			@connect_four.player.drops_disc_to_column_in_board(4, @connect_four.board).must_equal :player_has_won
    		end
    	end
    	
	end
end