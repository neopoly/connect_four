module ConnectFour
  class Board
    
    attr_reader :num_rows

    def initialize(num_columns=8, num_rows=8)
      @columns = (1..num_columns).inject([]) {|a,i| a << []}
      @num_rows = num_rows
      @num_columns = num_columns
    end

    def column_numbers
      (1..@num_columns).map {|i| i.to_s} .join("|")
    end

    def in_range?(column)
      (1..@num_columns).include? column
    end

    def is_full?(column)
      @columns[column - 1].length >= @num_rows
    end

    def put_piece(kind, column)
      @columns[column - 1] << kind
    end

    def to_s
      (0..@num_rows-1).reverse_each.map do |row|
        (0..@num_columns-1).map do |column|
          @columns[column][row] or "."
        end .join("|")
      end .join("\n")
    end

    def inspect
      (0..@num_rows-1).reverse_each.map do |row|
        (0..@num_columns-1).map do |column|
          @columns[column][row] or "."
        end
      end .join("\n")
    end
  end
end
