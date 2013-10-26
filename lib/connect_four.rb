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
	attr_accessor :player, :playero, :playerx, :grid

	def initialize number_of_columns, number_of_rows, number_of_discs_to_connect
		@player = @playero = Player.new('o', 31, 41)
		@playerx = Player.new('x', 33, 43)
		
		self.show_rules
		@grid = Grid.new number_of_columns, number_of_rows, number_of_discs_to_connect
		@grid.draw
	end
	
	def show_rules
		rules = 'Rules'
		puts rules
		rules
	end
	
	def play
		drop_to_column = (@player.name + " drop disc into column [1-7]: ").prompt
		if (self.in_range? drop_to_column)
			self.play_turn drop_to_column.to_i - 1
		else
			self.info_range_error
		end
		
		self.play
	end
	
	def play_turn drop_to_column
		player_play_state = @player.play @grid, drop_to_column
		if player_play_state === :replay
 			self.prompt_replay
		elsif player_play_state === :toggle_player
			self.toggle_player
		end
	end

	def in_range? column
		column.to_i >= 1 and column.to_i <= @grid.number_of_columns	
	end
	
	def info_range_error
		puts "Position is out of range [1-7]. Play again!"
	end

	def toggle_player
		@player = @player === @playero ? @playerx : @playero
	end
	
	def prompt_replay
 		is_replay = "Do you want to play again? Type [y] or [n]: ".prompt
 		if is_replay.to_s === "y\n".to_s
 			self.play_again
 		else
 			self.quit
 		end
	end
	
  	def play_again
		@player = @playero
		@grid.reset
		@grid.draw
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
	
	def play grid, column	
		grid.drop_disc column, self
	end
end

class Grid
	attr_accessor :number_of_columns, :number_of_rows, :number_of_discs_to_connect, :tiles, :discs
	
	def initialize number_of_columns, number_of_rows, number_of_discs_to_connect
		@number_of_columns = number_of_columns
		@number_of_rows = number_of_rows
		@number_of_discs_to_connect = number_of_discs_to_connect
		@tiles = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build
	end
	
	def build
		for column in 0...@number_of_columns
			for row in 0...@number_of_rows
				@tiles[column][row] = Tile.new column, row
			end
		end
	end

	def drop_disc col, player      #todo: refactor
		if not @discs[col]
			@discs[col] = Array.new
		end
		
 		if @discs[col].length < @tiles[col].length
 			row_insert_id = @discs[col].length
 			@discs[col][row_insert_id] = player.color
 			@tiles[col][row_insert_id].assign_to player
 			
 			if self.is_connected? col, row_insert_id, player
 				self.draw
 				player.wins
 				return :replay
 			end
 			
 			self.draw
 			return :toggle_player
 		else
 			puts "Column " + col.to_s + " is full. Please chose another one. "
 			puts player.name + " play again!"
 		end
 		return :next_turn
	end

	def is_connected? col, row, player
		self.finds_horizontal_connections? row, player or
		self.finds_vertical_connections? col, player or
		self.finds_diagonal_connections? false, col, row, player or
		self.finds_diagonal_connections? true, col, row, player
	end
	
	def matches_pattern? player, result
		result.include? player.color.to_s * @number_of_discs_to_connect
		puts result
	end
	
	def finds_vertical_connections? col, player
		result = @discs[col].join
		is_vertical = self.matches_pattern? player, result
	end
	
	def finds_horizontal_connections? row, player
		result = ''
		@tiles.each do |column|	
			result += column[row].color.to_s
		end
		is_horizontal = self.matches_pattern? player, result
	end
	
	def finds_diagonal_connections? is_anti, col, row, player
		anti = is_anti ? 1 : -1
		result = ''
		for i in -3..3
			if @tiles[col + i] and @tiles[col + i][row + i * anti] 
				result += @tiles[col + i][row + i * anti].color.to_s
			end
		end
		is_diagonal = self.matches_pattern? player, result
	end
		
	def reset
		@tiles = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build		
	end

	def draw
		#system "clear"
		puts ''
		puts '1234567'		#change to dynamic value
		for row_number in 0...@number_of_rows
			result = ''
			for col_number in 0...@number_of_columns
				result += @tiles[col_number].reverse[row_number].color.to_s
			end
			puts result
		end
		puts ''
	end
end

class Tile
	attr_accessor :col,:row, :color
	
	def initialize col,row
		@col = col
		@row = row
		@color = '_'.colorize(44).colorize(37)
	end
	
	def assign_to player
		@color = player.color.colorize(4)
	end
end


#RUN
@connect_four = ConnectFour.new @init_number_of_cols, @init_number_of_rows, @init_number_of_discs_to_connect
@connect_four.play