require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'connect_four'

class ConnectFourSpec < Minitest::Test
end

def initial_board_string
  "1 2 3 4 5 6 7 8\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n\n\n"
end
