class Board
	attr_accessor :number_of_columns, :number_of_rows, :number_of_discs_to_connect, :tilemap, :discs
	
	def initialize number_of_columns, number_of_rows, number_of_discs_to_connect
		@number_of_columns = number_of_columns
		@number_of_rows = number_of_rows
		@number_of_discs_to_connect = get_highest_number_of_discs_to_connect number_of_discs_to_connect
		@tilemap = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build_tilemap
	end
	
	def get_highest_number_of_discs_to_connect number_of_discs
		 [number_of_discs, [number_of_rows, number_of_columns].min].min
	end
	
	def build_tilemap
		for column in 0...@number_of_columns
			for row in 0...@number_of_rows
				@tilemap[column][row] = Tile.new column, row
			end
		end
	end
	
	def drop_disc_to column, player
		self.provide_column_for_discs column
			
 		if self.can_play_in_column? column, player
 			insert_row = self.insert_disc_to column, player
 			self.draw_board 			
 			return self.check_if_player_wins column, insert_row, player
 		else
 			return :player_repeats_turn
 		end
	end
	
	def check_if_player_wins column, row, player
		if self.is_connected? column, row, player
 			player.wins
 			return :player_has_won
 		else
 			return :player_has_played
 		end
	end

	def provide_column_for_discs column
		if not @discs[column]
			@discs[column] = Array.new
		end
	end

	def can_play_in_column? column, player
		if not self.column_is_full? column
			return true
		else
			self.info_player_about_full_column player, column
			return false
		end
	end

	def column_is_full? column
		not @discs[column].length < @tilemap[column].length
	end
	
	def info_player_about_full_column player,column
		puts "Column " + (column.to_i+1).to_s + " is full. Please chose another one. "
 		puts player.name + " play again!"
	end
		
	def insert_disc_to column, player
		insert_row = @discs[column].length
 		@discs[column][insert_row] = player.color
 		@tilemap[column][insert_row].assign_to player
 		return insert_row
	end
	
	def is_connected? col, row, player
		self.finds_horizontal_connections? row, player or
		self.finds_vertical_connections? col, player or
		self.finds_diagonal_connections? false, col, row, player or
		self.finds_diagonal_connections? true, col, row, player
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

	def checks_for_diagonal_tile_at_position column, row, diagonal_direction, position
		@tilemap[column + position] and @tilemap[column + position][row + position * diagonal_direction] 
	end
	
	def get_diagonal_tile_at_position column, row, diagonal_direction, position
		@tilemap[column + position][row + position * diagonal_direction].color.to_s
	end

	def matches_connection_in_search_result? player, search_result
		search_result.to_s.include? (player.color.to_s * @number_of_discs_to_connect).to_s
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