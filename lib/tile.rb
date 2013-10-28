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