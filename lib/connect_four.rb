require "connect_four/game"
require "connect_four/cli"

module ConnectFour
  def self.start
    @interface = CLI.new

    @interface.welcome
    players = @interface.ask_for_player_data
    @game = Game.new players

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
        @interface.full_error
      elsif error == 2
        @interface.range_error
      end
    end
  end
end
