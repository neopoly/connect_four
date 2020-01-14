module ConnectFour
  class Player
    attr_reader :symbol
    attr_reader :name
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end

    def ==(other)
      @name == other.name and @symbol == other.symbol
    end
  end
end
