module ConnectFour
  def self.hello_world
    "hello world"
  end
  def self.reset_board(board)
    board = Array.new(8) { Array.new(8, ".") }
  end
end
