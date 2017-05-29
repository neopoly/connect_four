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