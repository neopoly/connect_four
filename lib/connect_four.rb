require "connect_four/game"
require "connect_four/cli"

module ConnectFour
  def self.start
    interface = CLI.new
    player_strings = interface.start_screen
    players = player_strings.inject([]) do |players, p|
      name, piece = *p
      players << Player.new(name, piece)
    end
    board = Board.new
    game = Game.new interface, board, *players
    game.start
    puts

    while game.playing?
      interface.draw_interface game.game_state
      game.read_input
      interface.to_interface_origin
      game.update
      game.pass_turn
    end
  end
end
