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
		@grid.draw_grid
	end
	
	def show_rules
		rules = 'CONNECT FOUR'
		puts rules
		rules
	end
	
	def play
		player_drops_disc_to_column = (@player.name + " drop disc into column [1-7]: ").prompt.to_s.chomp.to_i
		if (self.checks_if_column_is_in_grid? player_drops_disc_to_column)
			self.play_turn player_drops_disc_to_column.to_i - 1
		else
			self.info_range_error
		end
		
		self.next_turn
	end
	
	def next_turn
		self.play
	end
	
	def play_turn player_drops_disc_to_column
		player_play_state = @player.play player_drops_disc_to_column, @grid
		if player_play_state === :replay
 			if self.ask_player_if_he_wants_to_play_again
 				self.play_again
 			else
 				self.quit
 			end
		elsif player_play_state === :toggle_player
			self.toggle_player
		end
	end

	def checks_if_column_is_in_grid? column
		column.to_i >= 1 and column.to_i <= @grid.number_of_columns	
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
		@grid.reset
		@grid.draw_grid
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
	
	def play column, grid	
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
		@column_labels = ''
		self.build
	end
	
	def build
		for column in 0...@number_of_columns
			for row in 0...@number_of_rows
				@tiles[column][row] = Tile.new column, row
			end
		end
	end

	def provide_column column
		if not @discs[column]
			@discs[column] = Array.new
		end
	end
	
	def connect_disc_with_grid column, player
		row = @discs[column].length
 		@discs[column][row] = player.color
 		@tiles[column][row].assign_to player
 		return row
	end
	
	def drop_disc column, player      #todo: refactor
		self.provide_column column
			
 		if @discs[column].length < @tiles[column].length
 			row = self.connect_disc_with_grid column, player
 			
 			if self.is_connected? column, row, player
 				self.draw_grid
 				player.wins
 				return :replay
 			end
 			
 			self.draw_grid
 			return :toggle_player
 		else
			self.informs_player_about_full_column player,column
 		end
 		return :next_turn
	end
	
	def informs_player_about_full_column player,column
		puts "Column " + (column.to_i+1).to_s + " is full. Please chose another one. "
 		puts player.name + " play again!"
	end

	def is_connected? col, row, player
		self.finds_horizontal_connections? row, player or
		self.finds_vertical_connections? col, player or
		self.finds_diagonal_connections? false, col, row, player or
		self.finds_diagonal_connections? true, col, row, player
	end
	
	def matches_pattern? player, result
		result.to_s.include? (player.color.to_s * @number_of_discs_to_connect).to_s
	end
	
	def finds_vertical_connections? column, player
		result = @discs[column].join
		self.matches_pattern? player, result
	end
	
	def finds_horizontal_connections? row, player
		result = ''
		@tiles.each do |column|	
			result += column[row].color.to_s
		end
		self.matches_pattern? player, result
	end
	
	def finds_diagonal_connections? is_anti, column, row, player
		anti = is_anti ? 1 : -1
		result = ''
		for i in -(@number_of_discs_to_connect-1)..(@number_of_discs_to_connect-1)
			if @tiles[column + i] and @tiles[column + i][row + i * anti] 
				result += @tiles[column + i][row + i * anti].color.to_s
			end
		end
		self.matches_pattern? player, result
	end
		
	def reset
		@tiles = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build		
	end

	def draw_grid
		system "clear"
		puts ''
		for row_number in 0...@number_of_rows
			result = ''
			for column_number in 0...@number_of_columns
				result += @tiles[column_number].reverse[row_number].color.to_s
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
		@color = (col + 1).to_s.colorize(44).colorize(34)
	end
	
	def assign_to player
		@color = player.color
	end
end


#RUN
@connect_four = ConnectFour.new @init_number_of_cols, @init_number_of_rows, @init_number_of_discs_to_connect
@connect_four.play