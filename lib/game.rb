class Game
  attr_reader :player, :game_board

  PLAYER_MARK_1 = 'x'.freeze
  PLAYER_MARK_2 = 'o'.freeze

  def initialize(dim=8, player=1)
    @player = player
    @game_board = GameBoard.new(dim)
  end

  def start
    while not game_board.game_over?
      # player x
      if player == 1
        print "player #{PLAYER_MARK_1}> "
      # player o
      else
        print "player #{PLAYER_MARK_2}> "
      end

      col = get_input
      if not col
        p "Please enter number between 1 - #{game_board.dim}"
        next
      end

      is_put = false
      # player x
      if player == 1
        is_put = game_board.put_mark(PLAYER_MARK_1, col)
      # player o
      else
        is_put = game_board.put_mark(PLAYER_MARK_2, col)
      end

      if is_put
        game_board.print_board

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

  def check_winner
    if game_board.game_over?
      if game_board.full_board?
        # Draw
        return 0
      else
        return player
      end
    # not yet end
    else
      return -1
    end
  end

  private
  def get_input
    col = gets.chomp.to_i

    if col > game_board.dim or col < 1
      return false
    else
      col = col.to_i - 1
      return col
    end
    rescue
      return false
  end

  def switch_turn
    if player == 1
      @player = 2
    elsif player == 2
      @player = 1
    else
      return false
    end
    true
  end
end
