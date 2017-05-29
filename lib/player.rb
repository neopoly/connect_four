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