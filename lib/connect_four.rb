require_relative "game/board"
require_relative "game/connect_four_game"

class ConnectFour
  def self.main
    Kernel.trap('INT') do
      Kernel.exit(0)
    end

    puts 'Would you like to play a game? input: y/n'
    input = read_input_until_include %w[y Y n N]
    @exit_requested = input =~ /n/i

    until @exit_requested
      @current_game = ConnectFourGame.new
      @current_game.start
      game_loop()
    end
  end

  def self.display_player_text
    player_text = @current_game.player_1_move? ? 'playerx' : 'playero'
    player_text << ' make a move! input: 1-8'
    puts player_text
  end

  def self.game_loop
    until @current_game.finished?
      puts @current_game.board.to_s
      display_player_text
      input = read_input_until_include ((1..8).to_a.map &:to_s)
      begin
        @current_game.make_move input.to_i
      rescue
        puts 'Invalid move'
      end
    end
    puts 'Would you like to play another game? input: y/n'
    input = read_input_until_include %w[y Y n N]
    @exit_requested = true if input =~ /n/i
  end

  def self.read_input_until_include(array)
    input = nil
    input = read_input until array.include? input
    input
  end

  def self.read_input
    gets.chomp.to_s.strip
  end

end

