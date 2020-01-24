module ConnectFour
  class Player
    attr_reader :piece

    def initialize(name, piece)
      @name = name
      @piece = piece
    end

    def ==(other)
      @name == other.to_s and @piece == other.piece
    end

    def to_s
      @name
    end
  end
end
