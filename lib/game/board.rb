require_relative 'mutable_matrix'

class Board

  EMPTY_FIELD = '.'.freeze

  def initialize(num_rows, num_cols, winning_length)
    # initialize board as '.'  filled matrix
    @fields = MutableMatrix.build(num_rows, num_cols) {EMPTY_FIELD}
    @win_condition_length = winning_length
  end

  def insert_char_at(character, column_number)
    raise 'Invalid column number' if column_number < 1 || column_number > @fields.column_count
    x = column_number - 1
    y = find_drop_point x
    raise 'Column full' if y < 0
    @fields.send(:[]=, y, x, character)
  end

  def find_drop_point(x)
    column = @fields.column x
    max_index = column.size - 1
    0.upto max_index do |y|
      return (y - 1) if column[y] != EMPTY_FIELD
    end

    max_index
  end

  def win_condition_met?
    (@fields.row_count - 1).downto 0 do |x|
      0.upto(@fields.column_count - 1) do |y|
        return true if winning_line_at? x, y
      end
    end

    false
  end

  def winning_line_at?(row, col)
    begin_of_line?(row, col, 0, 1) ||
      begin_of_line?(row, col, 1, 0) ||
      begin_of_line?(row, col, 1, 1) ||
      begin_of_line?(row, col, -1, 1)
  end

  def begin_of_line?(row, col, row_step, col_step)
    start_val = @fields[row, col]
    return false if start_val == EMPTY_FIELD

    1.upto(@win_condition_length - 1) do |i|
      test_row = row + i * row_step
      test_col = col + i * col_step
      # puts "from: #{col},#{row}, check: #{test_col},#{test_row}"
      return false if @fields[test_row, test_col] != start_val
    end
    true
  end

  def to_s
    string_value = ""
    @fields.row_vectors().each do |r|
      string_value << r.to_a.join('') << "\n"
    end
    string_value
  end

  def full?
    # if the top line includes no empty fields the board must be full
    !@fields.row(0).include? EMPTY_FIELD
  end

  def fill(field_array)
    @fields = MutableMatrix.rows field_array,false
  end

end
