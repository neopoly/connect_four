require './lib/helpers.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/tile.rb'

#CONNECT FOUR
class ConnectFour
	attr_accessor :player, :playero, :playerx, :board

	def initialize number_of_columns, number_of_rows, number_of_discs_to_connect
		@player = @playero = Player.new('o', 31, 41)
		@playerx = Player.new('x', 33, 43)
		
		self.show_rules
		@board = Board.new number_of_columns, number_of_rows, number_of_discs_to_connect
		@board.draw_board
	end
	
	def show_rules
		rules = 'CONNECT FOUR'
		puts rules
		rules
	end
	
	def play
		self.play_turn self.ask_player_to_drop_disc_in_a_column		
		self.play_next_turn
	end

	def play_turn column
		if self.check_that_column_is_in_range column
			player_action = @player.drops_disc_to_column_in_board column, @board
		
			if player_action === :player_has_won
 				if self.ask_player_if_he_wants_to_play_again
 					self.play_again
 				else
 					self.quit
 				end
			elsif player_action === :player_has_played
				self.toggle_player
			end
		end
	end
		
	def ask_player_to_drop_disc_in_a_column
		(@player.name + " drop disc into column [1-" + @board.number_of_columns.to_s + "]: ").prompt.to_s.chomp.to_i - 1 # - 1 for better array handling
	end
	
	def check_that_column_is_in_range column
		if (self.is_in_range? column)
			return column
		else
			self.info_range_error
			return false
		end
	end
	
	def is_in_range? column
		column.to_i >= 0 and column.to_i < @board.number_of_columns	
	end
	
	def info_range_error
		puts "Position is out of range [1-" + @board.number_of_columns.to_s + "]. Play again!"
	end

	def toggle_player
		@player = @player === @playero ? @playerx : @playero
	end
	
	def ask_player_if_he_wants_to_play_again
		ask_player = "Do you want to play again? Type [y] or [RETURN] to restart or [n] to quit: ".prompt.to_s.chomp
 		if  ask_player === 'y' or ask_player === ''
 			return true
 		elsif ask_player === 'n'
 			return false
 		else
 			self.ask_player_if_he_wants_to_play_again
 		end
	end

	def play_again
		@player = @playero
		@board.reset_tilemap
		@board.draw_board
		self.play
	end

	def quit
 		exit
	end

	def play_next_turn
		self.play
	end
end