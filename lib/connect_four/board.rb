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
      start_column = column-4 < 0 ? 0 : column - 4
      (start_column..column-1).each do |col|
        if @fields[row][col] != BLANK && @fields[row][col, 4].uniq.size == 1
          return true
        end
      end
      return false
    end

    def vertical_quartet? given_row, column
      start_row = given_row-3 < 0 ? 0 : given_row-3
      (start_row..given_row).each do |row|
        if @fields[row][column-1] != BLANK && @fields[row, 4].map {|r| r[column-1]}.uniq.size == 1
          return true
        end
      end
      return false
    end

    def ascending_quartet? given_row, column
      start_row = given_row+3 < ROWS ? given_row+3 : ROWS-1
      start_col = column-4 < 0 ? 0 : column-4
      (start_col..column-1).each do |col|
        (start_row.downto(given_row)).each do |row|
          if @fields[row][col] != BLANK && (0..3).map {|i| @fields[row-i][col+i]}.uniq.size == 1
            return true
          end
        end
      end
      return false
    end

    def descending_quartet? given_row, column
      startrow = given_row-3 < ROWS ? given_row-3 : ROWS-1
      start_col = column-4 < 0 ? 0 : column-4
      (start_col..column-1).each do |col|
        (startrow..given_row).each do |row|
          if @fields[row][col] != '-' && (0..3).map {|i| @fields[row+i][col+i]}.uniq.size == 1
            return true
          end
        end
      end
      return false
    end
  end
end
