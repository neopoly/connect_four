module ConnectFour
  def self.hello_world
    "hello world"
  end
  def self.reset_board(board)
    board = Array.new(8) { Array.new(8, ".") }
  end
  def self.is_valid_move(board, column)
    board[column-1].include?(".")
  end
  def self.make_move(board, column, token)
    free_index = board[column-1].rindex(".")
    board[column-1][free_index] = token
    return board[column-1][free_index]
  end
end
