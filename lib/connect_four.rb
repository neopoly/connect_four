module ConnectFour
  def self.hello_world
    "hello world"
  end

  def self.init_board(dim=8, player=1)
    @dim = dim
    @player = player
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
        self.switch_turn
        return @board
      end
    end
    @board[@dim-1][col] = mark
    self.switch_turn
    @board
  end

  def self.switch_turn
    if @player == 1
      @player = 2
    elsif @player == 2
      @player = 1
    else
      return false
    end
    true
  end

  def self.check_turn
    @player
  end
end
