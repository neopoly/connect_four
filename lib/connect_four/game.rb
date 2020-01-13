module ConnectFour
  class Game

    WIN_CONDITIONS = /([a-z])\1{3}/

    def initialize(board, *players)
      @board = board
      @players = players
      @turn = 0
      @playing = false
    end

    def pass_turn
      @turn = (@turn + 1) % @players.length
    end
  end
end
