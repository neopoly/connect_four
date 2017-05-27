require 'state_machines'

class ConnectFourGame

  SYMBOL_PLAYER_1 = 'x'.freeze
  SYMBOL_PLAYER_2 = 'o'.freeze

  attr_accessor :board
  state_machine :state, initial: :new do

    event :start do
      transition new: :player_1_move
    end

    event :make_move do
      transition player_1_move: :player_2_move,
                 player_2_move: :player_1_move
    end

    event :win do
      transition all => :finished
    end

    event :no_more_moves do
      transition all => :finished
    end

  end

  def make_move(column_number, *args)
    symbol = self.player_1_move? ? SYMBOL_PLAYER_1 : SYMBOL_PLAYER_2
    @board.insert_char_at symbol, column_number
    super(*args)
  end

  def initialize
    @board = Board.new 8, 8, 4
    super()
  end

  def done?
    @board.win_condition_met?
  end

end
