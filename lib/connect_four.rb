module ConnectFour
  def self.hello_world
    "hello world"
  end

  def self.init_board(dim=8)
    @dim = dim
    @board = []
    @dim.times do
      @board.push(Array.new(8,'.'))
    end
    @board
  end

  def self.put_mark(mark, col)
    for row in 0..@dim-1
      if @board[row][col] != '.'
        @board[row-1][col] = mark
        return @board
      end
    end
    @board[@dim-1][col] = mark
    @board
  end
end
