class ConnectFourGame

  attr_accessor :state, :board

  def initialize()
    @board = Board.new(8,8,4)
    @state = "new"
  end



end
