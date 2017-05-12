module ConnectFour
  class Board
    attr_accessor :fields

    BLANK = '-'
    COLUMNS = 8
    ROWS = 8

    def initialize
      @fields = Array.new(ROWS) { Array.new(COLUMNS, BLANK)}
    end

    def put_stone symbol, column
      row = ROWS-1
      row -= 1 until @fields[row].nil? || @fields[row][column-1] == BLANK
      @fields[row].nil? ? return : @fields[row][column-1] = symbol
      return row
    end

  end
end
