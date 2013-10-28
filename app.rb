require './lib/connect_four.rb'

#CONFIG VARS
@init_number_of_cols = 7
@init_number_of_rows = 6
@init_number_of_discs_to_connect = 4

#RUN
@connect_four = ConnectFour.new @init_number_of_cols, @init_number_of_rows, @init_number_of_discs_to_connect
@connect_four.play