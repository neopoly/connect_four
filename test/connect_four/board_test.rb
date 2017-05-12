require 'test_helper'

class ConnectFour::BoardTest < ConnectFourSpec
  describe ConnectFour::Board do
    let(:board) { ConnectFour::Board.new }

    describe "intitially" do
      it("should have 8 rows") { board.fields.length.must_equal 8 }
      it("should have all rows the same") { board.fields.uniq.size.must_equal 1 }
      it("should have 8 columns for each row") { board.fields.uniq.first.length.must_equal 8 }
      it("should heave the same content for each field") { board.fields.uniq.first.uniq.size.must_equal 1}
      it("should only have '-'s as content") { board.fields.uniq.first.uniq.first.must_equal "-" }
    end

  end
end
