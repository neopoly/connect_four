require "connect_four/game"

module ConnectFour
  def self.main
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
    Game.new board, player1, player2
  end
end
