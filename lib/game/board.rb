require 'matrix'

class Board

  EMPTY_FIELD = '.'
  attr_accessor :fields

  def initialize(num_rows, num_cols, winning_length)
    #initialize board as '.'  filled matrix
    @fields = Matrix.build(num_rows, num_cols) { EMPTY_FIELD }
    @win_condition_length = winning_length
  end

  def win_condition_met?
    (fields.row_count - 1).downto 0 do |y|
      0.upto(fields.column_count - 1) do |x|
        if winning_line_at? x, y
          return true
        end
      end
    end

    false
  end

  def winning_line_at?(row, col)
    is_begin_of_line?(row, col, 0, 1) ||
      is_begin_of_line?(row, col, 1, 0) ||
      is_begin_of_line?(row, col, 1, 1) ||
      is_begin_of_line?(row, col, -1, 1)
  end

  def is_begin_of_line?(row, col, row_step, col_step)
    start_val = @fields[row, col]
    if start_val == EMPTY_FIELD
      return false
    end

    1.upto(@win_condition_length - 1) do |i|
      test_row = row + i * row_step
      test_col = col + i * col_step
      if @fields[test_row, test_col] != start_val
        return false
      end
    end

    true
  end

  def to_s
    string_value = ""
    @fields.row_vectors().each do |r|
      string_value << r.to_a.join("") << "\n"
    end
    string_value
  end

end
