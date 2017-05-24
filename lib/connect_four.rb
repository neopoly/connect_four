require "game/connect_four_game"

module ConnectFour
  def self.hello_world
    "hello world"
  end

  def self.main
    puts "Would you like to play a game?"

    current_game = ConnectFourGame.new

    loop do
      puts
      input = gets.chomp
      command = input.split(/\s/)

      case command
        when /\Ahelp\z/i
          puts "super game help text for winners"
        else puts 'Invalid command'
      end
    end

  end

end
