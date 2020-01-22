require "logger"

module ConnectFour
  class Board
    COLUMN_DIVIDER = "|"

    def initialize(num_columns = 8, num_rows = 8)
      @columns = (1..num_columns).inject([]) { |a, i| a << [] }
      @num_rows = num_rows
      @num_columns = num_columns

      @logger = Logger.new("logfile.log")
    end

    def each_row
      if block_given?
        state.each_with_index do |row, index|
          yield row, index
        end
      else
        state.each
      end
    end

    def each_column
      if block_given?
        @columns.each_with_index do |column, index|
          yield column, index
        end
      else
        @columns.each
      end
    end

    def each_diagonal
      diagonals = scan_diagonals
      if block_given?
        diagonals.each do |diagonal|
          yield diagonal
        end
      else
        diagonals.each
      end
    end

    def state
      full_cols.transpose.reverse
    end

    def full?
      each_column.all? { |column| column.length >= @num_rows }
    end

    def in_range?(column)
      (1..@num_columns).include? column
    end

    def column_full?(column)
      @columns[column - 1].length >= @num_rows
    end

    def put_piece(kind, column)
      @columns[column - 1] << kind
    end

    def to_s
      concat_all_rows
    end

    private

    def scan_diagonals
      left_to_right_hash = Hash.new { |hash, key| hash[key] = [] }
      right_to_left_hash = Hash.new { |hash, key| hash[key] = [] }

      each_column do |column, c_index|
        each_row do |row, r_index|
          piece = @columns[c_index][r_index]
          left_to_right_hash[c_index + r_index] << piece
          right_to_left_hash[c_index - r_index] << piece
        end
      end

      left_to_right_hash.values + right_to_left_hash.values
    end

    def full_cols
      # fills columns with empt
      @columns.map { |column| column + [nil] * (@num_columns - column.length) }
    end

    def concat_row(row)
      row.join << "\n"
    end

    def concat_all_rows
      state.inject("") { |str, this_row| str << concat_row(this_row) }
    end
  end
end
