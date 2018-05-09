module ConnectFour
  def self.start_game
    game = Game.new
    game.start
  end

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
        # self.switch_turn
        return true
      end

      for row in 0..@dim-1
        if @board[row][col] != '.'
          @board[row-1][col] = mark
          @mark_pos = [row-1, col]
          # self.switch_turn
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
        # p 'Mark should be put before checking connect'
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
        # p 'Mark should be put before checking connect'
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
  end

  class Game
    attr_accessor :player, :game_board

    def initialize(dim=8, player=1)
      @player = player
      @game_board = GameBoard.new(dim)
    end

    def start
      # self.print_board
      while not game_over?
        col = get_input
        is_put = false
        # player x
        if @player == 1
          is_put = @game_board.put_mark('x', col)
        # player o
        else
          is_put = @game_board.put_mark('o', col)
        end

        if is_put
          @game_board.print_board

          case check_winner
          when -1
            switch_turn
          when 0
            p "Draw. The game is over."
          when 1
            p "Player x wins. The game is over."
          when 2
            p "Player o wins. The game is over."
          end
        end
      end
      true
    end

    def get_input
      # player x
      if @player == 1
        print "player x> "
      # player o
      else
        print "player o> "
      end

      col = gets.chomp.to_i

      if col > @game_board.dim or col < 1
        p "Please enter number between 1 - #{@game_board.dim}"
        get_input
      else
        col = col.to_i - 1
        return col
      end
      rescue
        p "Please enter number between 1 - #{@game_board.dim}"
        get_input
    end

    def switch_turn
      if @player == 1
        @player = 2
      elsif @player == 2
        @player = 1
      else
        return false
      end
      true
    end

    def check_winner
      if game_over?
        if @game_board.full_board?
          # Draw
          return 0
        else
          return @player
        end
      # not yet end
      else
        return -1
      end
    end

    def game_over?
      @game_board.connect_row? or @game_board.connect_col? or @game_board.connect_diag? or @game_board.full_board?
    end
  end
end

# ConnectFour.start_game
