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

    def horizontal_quartet? row, column
      (column-4..column-1).each do |col|
        if @fields[row][col] != BLANK && @fields[row][col, 4].uniq.size == 1
          return true
        end
      end
      return false
    end

  end
end
