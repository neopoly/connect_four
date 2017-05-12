module ConnectFour
  class Board
    attr_accessor :fields

    COLUMNS = 8
    ROWS = 8

    def initialize
      @fields = Array.new(ROWS) { Array.new(COLUMNS, '-')}
    end

    def put_stone symbol, col
      row = ROWS-1
      row -= 1 until @fields[row].nil? || @fields[row][col-1] == "-"
      @fields[row].nil? ? return : @fields[row][col-1] = symbol
      return row
    end

  end
end
