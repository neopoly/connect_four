require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'connect_four/game'
require 'connect_four/board'

class ConnectFourSpec < Minitest::Test
end

def initial_board_string
  "1 2 3 4 5 6 7 8\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n- - - - - - - -\n\n"
end

def board_and_prompt_string
  "#{initial_board_string}player x >"
end

def setup_fields(array_of_coordinates, symbol, _board = board)
  array_of_coordinates.each {|coordinates| _board.fields[coordinates.first][coordinates.last] = symbol}
end

def mute(obj = game)
  [:print, :puts, :p].each {|arg| obj.define_singleton_method(arg) {|string| nil}}
end

def give_input input, obj = game
  obj.define_singleton_method(:gets) {input}
end

def with_winner obj = game
  obj.define_singleton_method(:there_is_a_winner?) { |*x| true }
end

def without_winner obj = game
  obj.define_singleton_method(:there_is_a_winner?) { |*x| false }
end
