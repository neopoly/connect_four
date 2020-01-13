require 'test_helper'

class ConnectFourTest < ConnectFourSpec
	def setup
		@board = ConnectFour::Board.new
		@test = (1..8).inject([]) {|a,i| a << []}
	end

	def test_board
		assert_equal @test, @board.columns
		@board.put_piece "x", 5
		@test[4] << "x"
		assert_equal @test, @board.columns
	end

	def test_put_piece
		assert_nil @board.put_piece "x", 9
		assert_nil @board.put_piece "x", 0

		(1..8).each do |i|
			refute_nil @board.put_piece "x", i
		end
		assert_equal [["x"]]*8, @board.columns
	end

	def test_representation
		test_string = ("."*8 + "\n") * 8
		assert_equal test_string, @board.to_s

		test_string = ("."*8 + "\n") * 7 + ".x.x.x.x\n"
		(2..8).step(2).each {|i| @board.put_piece "x", i}
		assert_equal test_string, @board.to_s

		test_string = ("."*8 + "\n") * 6 + "...x....\n.x.x.x.x\n"
		@board.put_piece "x", 4
		assert_equal test_string, @board.to_s
	end
end
