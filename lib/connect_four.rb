require "connect_four/game"
require "connect_four/cli"

module ConnectFour
  def self.start
    cli = CLI.new
    names = cli.start_screen
    player1 = Player.new names[0], "x"
    player2 = Player.new names[1], "o"
    board = Board.new
    game = Game.new cli, board, player1, player2
    game.start

    while game.playing?
      game.render
      game.read_input
      game.update
      game.pass_turn
    end
  end
end
