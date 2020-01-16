require "connect_four/game"

module ConnectFour
  def self.start
    puts "Welcome to Connect Four!"
    puts "Who wants to play?"
    puts "Player 1: "
    print "Player 2: \033[A"
    name1 = gets.strip
    print "Player 2: "
    name2 = gets.strip
    player1 = Player.new name1, "x"
    player2 = Player.new name2, "o"
    board = Board.new
    game = Game.new board, player1, player2
    game.start

    while game.playing?
      game.render
      game.read_input
      game.update
      game.pass_turn
    end
  end
end
