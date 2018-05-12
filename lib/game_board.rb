class GameBoard
  attr_accessor :dim, :board, :mark_pos

  def initialize(dim=8)
    @dim = dim
    @board = []
    @mark_pos = [-1,-1]   #row,col

    @dim.times do
      @board.push(Array.new(@dim,'.'))
    end
    @board
  end

  def put_mark(mark, col)
    if @board[0][col] != '.'
      p 'This column is full or out of range. Pleaes put mark in other columns.'
      return false
    end

    if @board[@dim-1][col] == '.'
      @board[@dim-1][col] = mark
      @mark_pos = [@dim-1, col]
      return true
    end

    for row in 0..@dim-1
      if @board[row][col] != '.'
        @board[row-1][col] = mark
        @mark_pos = [row-1, col]
        return true
      end
    end
  end

  def print_board
    print"\n"
    for col in 0..@dim-1
      print col+1
    end
    print"\n"
    for row in 0..@dim-1
      for col in 0..@dim-1
        print @board[row][col]
      end
      print "\n"
    end
    print"\n"
    true
  end

  def connect_row?
    # check in the same row but different col
    row = @mark_pos[0]
    left = right = col = @mark_pos[1]   # col of mark_pos

    if @board[row][col] == '.' or @board[row][col] == nil
      return false
    end

    while left > 0 && @board[row][left-1] == @board[row][col]
      left = left-1
    end

    while right < @dim-1 && @board[row][right+1] == @board[row][col]
      right = right += 1
    end

    if right - left >= 3
      return true
    else
      return false
    end
  end

  def connect_col?
    # check in the same col but different row
    col = @mark_pos[1]
    up = down = row = @mark_pos[0]  # row of mark_pos

    if @board[row][col] == '.' or @board[row][col] == nil
      return false
    end

    while down > 0 && @board[down-1][col] == @board[row][col]
      down = down-1
    end

    while up < @dim - 1 && @board[up+1][col] == @board[row][col]
      up = up += 1
    end

    if up - down >= 3
      return true
    else
      return false
    end

  end

  def connect_diag?
    left_up = left_down = right_up = right_down = @mark_pos
    row = @mark_pos[0]
    col = @mark_pos[1]

    if @board[row][col] == '.' or @board[row][col] == nil
      return false
    end

    # left up corner to right down corner
    dis = 0
    while (left_up[0] > 0 && left_up[1] > 0) && @board[left_up[0]-1][left_up[1]-1] == @board[row][col]
      left_up = [left_up[0]-1, left_up[1]-1]
      dis += 1
    end

    while (right_down[0] < @dim-1 && right_down[1] < @dim-1) && @board[right_down[0]+1][right_down[1]+1] == @board[row][col]
      right_down = [right_down[0]+1, right_down[1]+1]
      dis += 1
    end

    if dis >= 3
      return true
    end

    # right up corner to left down corner
    dis = 0
    while (right_up[0] > 0 && right_up[1] < @dim-1) && @board[right_up[0]-1][right_up[1]+1] == @board[row][col]
      right_up = [right_up[0]-1, right_up[1]+1]
      dis += 1
    end

    while (left_down[0] < @dim-1 && left_down[1] > 0) && @board[left_down[0]+1][left_down[1]-1] == @board[row][col]
      left_down = [left_down[0]+1, left_down[1]-1]
      dis += 1
    end

    if dis >= 3
      return true
    else
      return false
    end
  end

  def full_board?
    for row in 0..@dim-1
      for col in 0..@dim-1
        if @board[row][col] == "."
          return false
        end
      end
    end
    return true
  end

  def game_over?
    connect_row? or connect_col? or connect_diag? or full_board?
  end
end
