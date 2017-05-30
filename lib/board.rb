class Board 
  def initialize
    @board = Array.new(8) { Array.new(8, ".") }
  end

  def reset_board
    @board = Array.new(8) { Array.new(8, ".") }
  end

  def is_valid_move?(column)
    raise "Wrong input." unless column.is_a?(Integer) && column >= 1 && column < 9
    @board[column-1].include?(".")
  end

  def make_move(column, token)
    raise "Token has invalid format." unless token.is_a?(String) && token.length == 1 
    if(is_valid_move?(column))
      free_index = @board[column-1].rindex(".")
      @board[column-1][free_index] = token 
      return true
    else
      return false
    end  
  end

  def print_board
    for y in 0..7
      for x in 0..7
        print "#{@board[x][y]}"
      end
      print "\n"
    end
  end  
end
