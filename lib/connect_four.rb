require_relative "game/board"
require_relative "game/connect_four_game"

module ConnectFour
  def self.main

    Kernel.trap('INT') do
      Kernel.exit(0)
    end

    puts 'Would you like to play a game? input: y/n'
    @exit_requested = false

    input = gets.chomp.to_s.strip
    @exit_requested = true if input =~ /n/i

    until @exit_requested
      @current_game = ConnectFourGame.new
      @current_game.start
      game_loop()
    end
  end

  def self.game_loop
    until @current_game.done?
      puts @current_game.board.to_s
      player_text = @current_game.player_1_move? ? 'playerx' : 'playero'
      player_text << ' make a move! input: 1-8'
      puts player_text
      input = 0
      until (1..8).to_a.include? input
        input = gets.chomp.to_s.to_i
      end
      @current_game.make_move input
    end
    puts 'Would you like to play another game? input: y/n'
    input = gets.chomp.to_s.strip
    @exit_requested = true if input =~ /n/i
  end

end

