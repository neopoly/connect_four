#CONFIG VARS
@init_number_of_cols = 7
@init_number_of_rows = 6
@init_number_of_discs_to_connect = 4


#HELPERS
class String
	def prompt
		print(self.to_s)
		gets
	end
	
	def colorize color_code
		"\e[#{color_code}m#{self}\e[0m"
	end
end


#CONNECT FOUR CLASSES
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
		target_column = (@player.name + " drop disc into column [1-7]: ").prompt.to_s.chomp.to_i
		
		if (self.is_in_range? target_column)
			self.play_turn target_column.to_i - 1
		else
			self.info_range_error
		end
		
		self.next_turn
	end
	
	def next_turn
		self.play
	end
	
	def play_turn column
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

	def is_in_range? column
		column.to_i >= 1 and column.to_i <= @board.number_of_columns	
	end
	
	def info_range_error
		puts "Position is out of range [1-7]. Play again!"
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
end

class Player
	attr_accessor :color, :name
	
	def initialize color, foreground_colorcode, background_colorcode
		@color = color.colorize(background_colorcode).colorize(foreground_colorcode)
		@name = 'Player ' + color.to_s.colorize(background_colorcode).colorize(foreground_colorcode)
	end

	def wins
		puts @name + ' wins this game!'
		puts ''
	end
	
	def drops_disc_to_column_in_board column, board	
		board.drop_disc_to column, self
	end
end

class Board
	attr_accessor :number_of_columns, :number_of_rows, :number_of_discs_to_connect, :tiles, :discs
	
	def initialize number_of_columns, number_of_rows, number_of_discs_to_connect
		@number_of_columns = number_of_columns
		@number_of_rows = number_of_rows
		@number_of_discs_to_connect = number_of_discs_to_connect
		@tilemap = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build_tilemap
	end
	
	def build_tilemap
		for column in 0...@number_of_columns
			for row in 0...@number_of_rows
				@tilemap[column][row] = Tile.new column, row
			end
		end
	end

	def provide_column column
		if not @discs[column]
			@discs[column] = Array.new
		end
	end
	
	def insert_disc_to column, player
		insert_row = @discs[column].length
 		@discs[column][insert_row] = player.color
 		@tilemap[column][insert_row].assign_to player
 		return insert_row
	end
	
	def column_is_full? column
		not @discs[column].length < @tilemap[column].length
	end
	
	def drop_disc_to column, player
		self.provide_column column
			
 		if not self.column_is_full? column
 			insert_row = self.insert_disc_to column, player
 			self.draw_board
 			 			
 			if self.is_connected? column, insert_row, player
 				player.wins
 				return :player_has_won
 			else
 				return :player_has_played
 			end
 			
 		else
			self.inform_player_about_full_column player, column
			return :player_repeats_turn
 		end
	end
	
	def inform_player_about_full_column player,column
		puts "Column " + (column.to_i+1).to_s + " is full. Please chose another one. "
 		puts player.name + " play again!"
	end

	def is_connected? col, row, player
		self.finds_horizontal_connections? row, player or
		self.finds_vertical_connections? col, player or
		self.finds_diagonal_connections? false, col, row, player or
		self.finds_diagonal_connections? true, col, row, player
	end
	
	def matches_connection_in_search_result? player, search_result
		search_result.to_s.include? (player.color.to_s * @number_of_discs_to_connect).to_s
	end
	
	def finds_vertical_connections? column, player
		search_result = @discs[column].join
		self.matches_connection_in_search_result? player, search_result
	end
	
	def finds_horizontal_connections? row, player
		search_result = ''
		@tilemap.each do |column|	
			search_result += column[row].color.to_s
		end
		self.matches_connection_in_search_result? player, search_result
	end
	
	def finds_diagonal_connections? is_antidiagonal, column, row, player
		diagonal_direction = is_antidiagonal ? 1 : -1
		search_result = ''
		for position in self.get_diagonal_search_range
			if self.checks_for_diagonal_tile_at_position column, row, diagonal_direction, position
				search_result += self.get_diagonal_tile_at_position column, row, diagonal_direction, position
			end
		end
		self.matches_connection_in_search_result? player, search_result
	end

	def get_diagonal_search_range
		-(@number_of_discs_to_connect-1)..(@number_of_discs_to_connect-1)
	end

	def	checks_for_diagonal_tile_at_position column, row, diagonal_direction, position
		@tilemap[column + position] and @tilemap[column + position][row + position * diagonal_direction] 
	end
	
	def get_diagonal_tile_at_position column, row, diagonal_direction, position
		@tilemap[column + position][row + position * diagonal_direction].color.to_s
	end
		
	def reset_tilemap
		@tilemap = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build_tilemap	
	end

	def draw_board
		system "clear"
		puts ''
		for row_number in 0...@number_of_rows
			console_output = ''
			for column_number in 0...@number_of_columns
				console_output += @tilemap[column_number].reverse[row_number].color.to_s
			end
			puts console_output
		end
		puts ''
	end
end

class Tile
	attr_accessor :column,:row, :color
	
	def initialize column,row
		@column = column
		@row = row
		@color = (column + 1).to_s.colorize(44).colorize(34)
	end
	
	def assign_to player
		@color = player.color
	end
end


#RUN
@connect_four = ConnectFour.new @init_number_of_cols, @init_number_of_rows, @init_number_of_discs_to_connect
@connect_four.play