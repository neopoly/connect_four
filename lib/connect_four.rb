require "connect_four/game"
require "connect_four/cli"

module ConnectFour
  def self.start
    @interface = CLI.new

    @interface.welcome
    player_strings = @interface.ask_for_player_data
    @interface.exit_info

    players = player_strings.inject([]) do |players, p|
      name, piece = *p
      players << Player.new(name, piece)
    end
    @game = Game.new *players
    @game_over = false

    until @game_over
      @interface.draw_interface @game.game_state
      process_input
      @interface.reset
      @game_over = @game.update
      @game.pass_turn if not @game_over
    end

    if @game_over == 1
      @interface.win_message @game.game_state
    elsif @game_over == 2
      @interface.full_message
    end
  end

  def self.process_input
    error = 0
    while error
      column_number = @interface.get_input_column
      error = @game.read_input column_number

      if error == 1
        @interface.error_message "RANGE_ERROR"
      elsif error == 2
        @interface.error_message "FULL_ERROR"
      end
    end
  end
end
