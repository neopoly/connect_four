require 'board'

class Game
  def initialize(input = STDIN, output = STDOUT)
    @board, @moves, @input, @output = Board.new, 0, input, output
  end

  def make_move_player1(column)
    @board.make_move(column, "x")
  end

  def make_move_player2(column)
    @board.make_move(column, "o")
  end
  
  def did_player1_win?(column)
    if @board.connected_horizontally?(column, "x") || @board.connected_vertically?(column, "x") || @board.connected_diagonally_desc?(column, "x") || @board.connected_diagonally_asc?(column, "x")
      return true
    else
      return false
    end
  end

  def did_player2_win?(column)
    if @board.connected_horizontally?(column, "o") || @board.connected_vertically?(column, "o") || @board.connected_diagonally_desc?(column, "o") || @board.connected_diagonally_asc?(column, "o")
      return true
    else
      return false
    end
  end
  
  def get_input
    @input.gets.chomp.to_i
  end 

  def get_move_pos(player)
    @output.puts("#{player}, please enter the number of the column you wish to insert your piece into.")
    move_pos = get_input
    return move_pos
  end

  def get_valid_move_pos(player)
    move_pos = get_move_pos(player)
    if move_pos < 1 || move_pos > 8 
      @output.puts("Your last input was invalid. Please only enter numbers between 1 and 8.") 
      move_pos = get_valid_move_pos(player)
    end
    return move_pos
  end

  def play
    while @moves < 64 do
      column_num = get_valid_move_pos("Player 1")
      player1_moved = make_move_player1(column_num)
      while !player1_moved do
        column_num = get_valid_move_pos("Player 1")
        player1_moved = make_move_player1(column_num)
      end
      @output.puts("The board:")
      @output.puts"#{@board.print_board}"
      @moves += 1
      if did_player1_win?(column_num)
        @output.puts("Player 1 won.")
        return 1
      end
       
      column_num = get_valid_move_pos("Player 2")
      player2_moved = make_move_player2(column_num)
      while !player2_moved do
        column_num = get_valid_move_pos("Player 2")
        player2_moved = make_move_player2(column_num)
      end
      @output.puts("The board:")
      @output.puts "#{@board.print_board}"
      @moves += 1
      if did_player2_win?(column_num)
        @output.puts("Player 2 won.")
        return 2
      end
    end
    @output.puts("Neither player won.")
    return 0
  end
end
