require_relative 'game_board'
require_relative 'game'

module ConnectFour
  def self.start_game(dim=8, player=1)
    game = Game.new(dim, player)
    game.start
  end
end
