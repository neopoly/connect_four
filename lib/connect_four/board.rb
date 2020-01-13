module ConnectFour
  class Board
    
    attr_reader :columns

    def initialize
      @columns = (1..8).inject([]) {|a,i| a << []}
    end

    def put_piece(kind, column)
      if (1..8).include? column and @columns[column-1].length < 8
        @columns[column-1] << kind
      end
    end

    def to_s
      (0..7).reverse_each.inject("") do |string, row|
        string << (0..7).inject("") {|line, column| line << (@columns[column][row] or ".")} << "\n"
      end
    end
  end
end
