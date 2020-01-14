require "connect_four/player"
require "connect_four/board"

module ConnectFour
  class Game

    WIN_STATES = /x{4}|(x[.\n]{8}){3}x|(x[.\n]{7}){3}x|(x[.\n]{9}){3}x/

    def initialize(board, *players)
      @board = board
      @players = players
      @turn = 0
      @playing = false
    end

    def pass_turn
      @turn = (@turn + 1) % @players.length
    end

    def win?
      @board.to_s.match?(WIN_STATES)
    end

    def current_player
      @players[@turn]
    end
  end
end
