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
    raise "Token is invalid." unless token == "x" || token == "o"
    if(is_valid_move?(column))
      free_index = @board[column-1].rindex(".")
      @board[column-1][free_index] = token 
      return true
    else
      return false
    end  
  end
  
  def are_four_connected?(column, token)
    raise "Token is invalid." unless token == "x" || token == "o"
    raise "Token not in expected position." unless @board[column-1].rindex(".")+1 == @board[column-1].index(token)

    counter = 0
    x_pos = column-1
    y_pos = @board[column-1].index(token)
    smaller_pos = [x_pos, y_pos].min
    
    #Horizontal
    for x in 0..7
      if(@board[x][y_pos] == token)
        counter += 1
        if(counter > 3)
          return true
        end
      else
        counter = 0
      end
    end
    counter = 0
    
    #Vertical
    for y in 0..7
      if(@board[x_pos][y] == token)
        counter += 1
        if(counter > 3)
          return true
        end
      else
        counter = 0
      end
    end
    counter = 0

    #Diagonal desc
    start_x1 = x_pos - smaller_pos
    start_y1 = y_pos - smaller_pos
    max_moves1 = 7 - [start_x1, start_y1].max
    for m in 0..max_moves1
      if(@board[start_x1 + m][start_y1 + m] == token)
        counter += 1
        if(counter > 3)
          return true
        end
      else
        counter = 0
      end  
    end     
    counter = 0
    
    #Diagonal asc
    max_moves2 = [7 - x_pos, y_pos].min
    start_x2 = y_pos - max_moves2
    start_y2 = x_pos + max_moves2
    max_moves2 = [7 - start_x2, start_y2].min
    for m in 0..max_moves2
      if(@board[start_x2 + m][start_y2 - m] == token)
        counter += 1
        if(counter > 3)
          return true
        end
      else
        counter = 0
      end
    end
    counter = 0

    return false 
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
