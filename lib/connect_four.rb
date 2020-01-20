require "connect_four/game"
require "connect_four/cli"

module ConnectFour
  def self.start
    cli = CLI.new
    player_strings = cli.start_screen
    players = player_strings.inject([]) do |players, p|
      name, piece = *p
      players << Player.new(name, piece)
    end
    board = Board.new
    game = Game.new cli, board, *players
    game.start

    while game.playing?
      game.render
      game.read_input
      game.update
      game.pass_turn
    end
  end
end
