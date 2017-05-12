module ConnectFour
  class Game
    attr_accessor :board

    def initialize
      @board = Board.new
    end
  end
end
