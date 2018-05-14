class Game

  PLAYER_MARK1 = 'x'.freeze
  PLAYER_MARK2 = 'o'.freeze

  attr_reader :player, :game_board

  def initialize(dim = 8, player = 1)
    @player = player
    @game_board = GameBoard.new(dim)
  end

  def start
    until game_board.game_over?
      player_mark = player == 1? PLAYER_MARK1 : PLAYER_MARK2

      print "player #{player_mark}> "
      col = get_input
      unless col
        puts "Please enter number between 1 - #{game_board.dim}"
        next
      end

      is_put = false || game_board.put_mark(player_mark, col)
      next unless is_put

      game_board.print_board
      case check_winner
      when -1
        switch_turn
      when 0
        puts "Draw. The game is over."
      else  # 1 or 2
        puts "Player #{player_mark} wins. The game is over."
      end
    end
    true
  end

  def check_winner
    if game_board.game_over?
      if game_board.full_board?
        return 0  # draw
      else
        return player
      end
    # not yet game over
    else
      return -1
    end
  end

  private
  def get_input
    col = gets.chomp.to_i

    if col > game_board.dim || col < 1
      return false
    else
      col = col.to_i - 1
      return col
    end
    rescue
      return false
  end

  def switch_turn
    @player = player == 1? 2:1
  end
end
