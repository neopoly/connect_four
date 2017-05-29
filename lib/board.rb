class Board 
  def initialize()
    @board, @freeSlots = Array.new(8) { Array.new(8, ".") }, 64
  end

  def resetBoard()
    @board = Array.new(8) { Array.new(8, ".") }
    @freeSlots = 64
  end

  def isValidMove(x)
    @board[x-1].include?(".")
  end

  def makeMove(x, token)
    if(isValidMove(x))
      free_index = @board[x-1].rindex(".")
      @board[x-1][free_index] = token
      @freeSlots -= 1 
      return true
    else
      return false
    end  
  end

  def printBoard()
    for y in 0..7
      for x in 0..7
        print "#{@board[x][y]}"
      end
      print "\n"
    end
  end  
end
