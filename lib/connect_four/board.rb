module ConnectFour
  class Board
    
    def initialize(num_columns=8, num_rows=8)
      @columns = (1..num_columns).inject([]) {|a,i| a << []}
      @num_rows = num_rows
      @num_columns = num_columns
    end

    private

    def rows
      (0...@num_rows).reverse_each.map {|row| @columns.map {|col| col[row] or "."} }
    end

    def column_numbers
      (1..@num_columns).map {|i| i.to_s} .join("|") << "\n"
    end

    public

    def state(string)
      case string
        when "cols"
          @columns
        when "rows"
          rows
        end
    end

    def string_height
      # number of rows + column numbers row (1)
      @num_rows + 1
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
      column_numbers << rows.inject("") {|str, row| str << row.join("|") << "\n"}
    end
  end
end
