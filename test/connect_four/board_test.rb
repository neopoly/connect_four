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

    describe "#put_stone" do
      before { board.put_stone('x', 3) }
      it("should have that stone stored at the bottom of selected column") { board.fields[7][2].must_equal 'x' }

      it "should have all other fields unaffected" do
        board.fields.each_with_index do |row, y|
          row.each_with_index do |field, x|
            field.must_equal '-' unless y == 7 && x == 2
          end
        end
      end

      it("should store a second stone in the same column on top of the first") do
        board.put_stone('x', 3)
        board.fields[6][2].must_equal 'x'
      end

      it("shouldn't let you put more than 8 stones in a column") do
        7.times { board.put_stone('x', 3) }
        proc { board.put_stone('x', 3) }.must_output "This stack is packed\n"
      end
    end
  end
end
