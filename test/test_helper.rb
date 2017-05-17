require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'connect_four/game'
require 'connect_four/board'

class ConnectFourSpec < Minitest::Test
end

def initial_board_string
  "1 2 3 4 5 6 7 8\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n\n\n"
end

def setup_fields array_of_coordinates, symbol
  array_of_coordinates.each { |coordinates| board.fields[coordinates.first][coordinates.last] = symbol }
end
