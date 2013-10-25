#HELPERS
class String
	def prompt
 	  	print(self.to_s)
    	gets
	end
end

#CONNECT FOUR CLASSES
class ConnectFour
	attr_accessor :player, :playero, :playerx, :grid
	
	def initialize number_of_columns, number_of_rows
		@player = @playero = {}
		@playerx = {}
		
		puts self.show_rules
		
		@grid = {}
	end
	
	def show_rules
		'Rules'
	end
	def in_range? column
		(1..@grid.number_of_columns).include?(column)	
	end
	
	def play
		drop_to_column = (@player.name + " drop disc into column [1-7]: ").prompt	
		if (in_range? drop_to_column)
			status = @player.play
			if status === 1
 				self.prompt_replay
			elsif status === 0
				self.toggle_player
			end
		else
			self.info_range_error
		end
		
		self.play
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
  		self.play
  	end
  	
  	def quit
 		exit
  	end
end

class Player
	attr_accessor :color, :name
end

class Grid
	attr_accessor :number_of_columns, :number_of_rows, :tiles, :discs
	
	def initialize number_of_columns, number_of_rows
		@number_of_columns = number_of_columns
		@number_of_rows = number_of_rows
		@tiles = Array.new(@number_of_columns) { Array.new(@number_of_rows) }
		@discs = Array.new
		self.build
	end
	
	def build
		for col in 0...@number_of_columns
			for row in 0...@number_of_rows
				@tiles[col][row] = {}
			end
		end
	end

	def drop_disc col, player

	end

	def is_connected? col, row, player
		self.finds_horizontal_connections? row, player or
		self.finds_vertical_connections? col, player or
		self.finds_diagonal_connections? false, col, row, player or
		self.finds_diagonal_connections? true, col, row, player
	end
	
	def matches_pattern? player, result
		result.include? player.color.to_s * 4
	end
	
	def finds_vertical_connections? col, player

	end
	
	def finds_horizontal_connections? row, player

	end
	
	def finds_diagonal_connections? is_anti, col, row, player

	end
	
	def reset

	end

	def draw

	end
end
