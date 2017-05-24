require_relative "game/board"
require_relative "game/connect_four_game"

module ConnectFour
  def self.hello_world
    "hello world"
  end


  def self.main
    exit_requested = false
    Kernel.trap( "INT" ) do
      Kernel.exit(0)
    end

    puts "Would you like to play a game?"
    current_game = ConnectFourGame.new

    while !exit_requested do


      puts current_game.board.to_s
      input = gets.chomp.to_s
      command = input.strip


      case command
        when 'help'
          puts "super game help text for winners"
        else puts 'Invalid command'
      end
    end

  end

end
