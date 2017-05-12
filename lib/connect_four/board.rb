module ConnectFour
  class Board
    attr_accessor :fields

    COLUMNS = 8
    ROWS = 8

    def initialize
      @fields = Array.new(ROWS) { Array.new(COLUMNS, '-')}
    end

  end
end
