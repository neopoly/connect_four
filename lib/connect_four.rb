module ConnectFour
  def self.hello_world
    "hello world"
  end

  def self.init_board(dim=8, player=1)
    @dim = dim
    @player = player
    @board = []
    @mark_pos = [-1,-1]   #row,col

    @dim.times do
      @board.push(Array.new(@dim,'.'))
    end
    @board
  end

  def self.put_mark(mark, col)

    if @board[@dim-1][col] == '.'
      @board[@dim-1][col] = mark
      @mark_pos = [@dim-1, col]
      self.switch_turn
      return @board
    end

    for row in 0..@dim-1
      if @board[row][col] != '.'
        @board[row-1][col] = mark
        @mark_pos = [row-1, col]
        self.switch_turn
        return @board
      end
    end
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

  def self.connect_row?
  end

  def self.connect_col?
  end

  def self.connect_diag?
  end

  def self.full_board?
  end

  def self.game_over?
  end
end
