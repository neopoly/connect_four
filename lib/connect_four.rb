module ConnectFour
  def self.hello_world
    "hello world"
  end
  #def self.reset_board(board)
  #  board.resetBoard()
  #end
  #def self.is_valid_move(board, column)
  #  board.isValidMove(column)
  #end
  def self.make_move(board, column, token)
    board.makeMove(column, token)
  end
end
