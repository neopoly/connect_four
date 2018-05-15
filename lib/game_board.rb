class GameBoard

  EMPTY_MARK = '.'.freeze

  attr_reader :dim, :board, :mark_pos

  def initialize(dim = 8)
    @dim = dim
    @board = []
    @mark_pos = [-1,-1]   # row,col

    dim.times do
      board.push(Array.new(dim,EMPTY_MARK))
    end
  end

  def put_mark(mark, col)
    if board[0][col] != EMPTY_MARK
      puts 'This column is full or out of range. Please put the mark in other columns.'
      return false
    end

    if board[dim-1][col] == EMPTY_MARK
      board[dim-1][col] = mark
      @mark_pos = [dim-1, col]
      return true
    end

    0.upto(dim-1) do |row|
      if board[row][col] != EMPTY_MARK
        board[row-1][col] = mark
        @mark_pos = [row-1, col]
        return true
      end
    end
  end

  def print_board
    puts
    0.upto(dim-1) do |col|
      print col+1
    end
    puts

    0.upto(dim-1) do |row|
      0.upto(dim-1) do |col|
        print board[row][col]
      end
      puts
    end
    puts
    true
  end

  def connect_row?
    # check in the same row but different col
    row = mark_pos[0]
    left = right = col = mark_pos[1]   # col of mark_pos
    mark = board[row][col]

    return false if mark == EMPTY_MARK || mark == nil

    left -= 1 while left > 0 && board[row][left-1] == mark
    right += 1 while right < dim-1 && board[row][right+1] == mark

    return right - left >= 3
  end

  def connect_col?
    # check in the same col but different row
    col = mark_pos[1]
    up = down = row = mark_pos[0]  # row of mark_pos
    mark = board[row][col]

    return false if mark == EMPTY_MARK || mark == nil

    down -= 1 while down > 0 && board[down-1][col] == mark
    up += 1 while up < dim - 1 && board[up+1][col] == mark

    return up - down >= 3
  end

  def connect_diag?
    left_up = left_down = right_up = right_down = mark_pos
    row = mark_pos[0]
    col = mark_pos[1]
    mark = board[row][col]

    return false if mark == EMPTY_MARK || mark == nil

    # left up corner to right down corner
    dis = 0
    while (left_up[0] > 0 && left_up[1] > 0) &&
           board[left_up[0]-1][left_up[1]-1] == mark

      left_up = [left_up[0]-1, left_up[1]-1]
      dis += 1
    end

    while (right_down[0] < dim-1 && right_down[1] < dim-1) &&
           board[right_down[0]+1][right_down[1]+1] == mark

      right_down = [right_down[0]+1, right_down[1]+1]
      dis += 1
    end

    return true if dis >= 3

    # right up corner to left down corner
    dis = 0
    while (right_up[0] > 0 && right_up[1] < dim-1) &&
           board[right_up[0]-1][right_up[1]+1] == mark

      right_up = [right_up[0]-1, right_up[1]+1]
      dis += 1
    end

    while (left_down[0] < dim-1 && left_down[1] > 0) &&
           board[left_down[0]+1][left_down[1]-1] == mark

      left_down = [left_down[0]+1, left_down[1]-1]
      dis += 1
    end

    return dis >= 3
  end

  def full_board?
    0.upto(dim-1) do |row|
      0.upto(dim-1) do |col|
        if board[row][col] == EMPTY_MARK
          return false
        end
      end
    end
    return true
  end

  def game_over?
    connect_row? || connect_col? || connect_diag? || full_board?
  end
end
