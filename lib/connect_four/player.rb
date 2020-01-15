module ConnectFour
  class Player
    attr_reader :piece
    attr_reader :name

    def initialize(name, piece)
      @name = name
      @piece = piece
    end

    def ==(other)
      @name == other.name and @piece == other.piece
    end
  end
end
