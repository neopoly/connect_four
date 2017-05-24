require 'test_helper'

class ConnectFour::BoardTest < ConnectFourSpec
  describe ConnectFour::Board do
    let(:board) { ConnectFour::Board.new }

    describe 'intitially' do
      it('has 8 rows') { board.fields.length.must_equal 8 }
      it('has all rows the same') { board.fields.uniq.size.must_equal 1 }
      it('has 8 columns for each row') { board.fields.uniq.first.length.must_equal 8 }
      it('has the same content for each field') { board.fields.uniq.first.uniq.size.must_equal 1}
      it("has only '-'s as content") { board.fields.uniq.first.uniq.first.must_equal '-'}
    end

    describe '#stringified' do
      it 'returns a string version of the board' do
        board.stringified.must_equal initial_board_string
      end
    end

    describe '#put_stone' do
      before { board.put_stone('x', 3) }
      it('has the stone stored at the bottom of selected column') { board.fields[7][3].must_equal 'x' }

      it 'has all other fields unaffected' do
        board.fields.each_with_index do |row, y|
          row.each_with_index do |field, x|
            field.must_equal '-' unless y == 7 && x == 3
          end
        end
      end

      it('stores a second stone in the same column on top of the first') do
        board.put_stone('x', 3)
        board.fields[6][3].must_equal 'x'
      end

      it('returns the final row and column of the stone') { board.put_stone('x', 3).must_equal [6, 3] }

      it('returns nil if you try to put more than 8 stones in a column') do
        7.times { board.put_stone('x', 3) }
        board.put_stone('x', 3).must_be_nil
      end
    end

    describe '#horizontal_quartet?' do
      it 'returns true when 3 fields to the left are the same as the given' do
        setup_fields [[4,0],[4,1],[4,2],[4,3]], 'x'
        board.horizontal_quartet?(4,3).must_equal true
      end
      it 'returns true when 3 fields to the right are the same as the given' do
        setup_fields [[4,0],[4,1],[4,2],[4,3]], 'x'
        board.horizontal_quartet?(4,0).must_equal true
      end
      it 'returns true when 2 fields to the left and 1 to the right are the same as the given' do
        setup_fields [[4,0],[4,1],[4,2],[4,3]], 'x'
        board.horizontal_quartet?(4,2).must_equal true
      end
      it 'returns false when 2 fields to the right are the same as the given' do
        setup_fields [[4,0],[4,1],[4,2]], 'x'
        board.horizontal_quartet?(4,0).must_equal false
      end
      it 'returns false when 2 fields to the left are the same as the given' do
        setup_fields [[4,0],[4,1],[4,2]], 'x'
        board.horizontal_quartet?(4,2).must_equal false
      end
      it 'returns false when 1 fields to the left and 1 to the right are the same as the given' do
        setup_fields [[4,0],[4,1],[4,2]], 'x'
        board.horizontal_quartet?(4,1).must_equal false
      end
      it 'returns false when 1 fields on the very right to the right is set' do
        setup_fields [[7,7]], 'x'
        board.horizontal_quartet?(7,7).must_equal false
      end
    end

    describe '#vertical_quartet?' do
      it 'returns true when 3 fields below are the same as the given' do
        setup_fields [[6,3],[5,3],[4,3],[3,3]], 'x'
        board.vertical_quartet?(3,3).must_equal true
      end
      it 'returns true when 3 fields below are the same as the given starting on the bottom row' do
        setup_fields [[7,3],[6,3],[5,3],[4,3]], 'x'
        board.vertical_quartet?(4,3).must_equal true
      end
      it 'returns true when 3 fields below are the same as the given ending on the top row' do
        setup_fields [[3,3],[2,3],[1,3],[0,3]], 'x'
        board.vertical_quartet?(0,3).must_equal true
      end
      it 'returns false when 2 fields below are the same as the given' do
        setup_fields [[3,3],[2,3],[1,3]], 'x'
        board.vertical_quartet?(1,3).must_equal false
      end
      it 'returns false when 4 fields in the next column are the same' do
        setup_fields [[4,3],[3,3],[2,3],[1,3]], 'x'
        board.vertical_quartet?(1,4).must_equal false
      end
      it 'returns false when the top left field is set' do
        setup_fields [[0,0]], 'x'
        board.vertical_quartet?(0,0).must_equal false
      end
      it 'returns false when the bottom right field is set' do
        setup_fields [[7,7]], 'x'
        board.vertical_quartet?(7,7).must_equal false
      end
    end

    describe '#ascending_quartet?' do
      it 'returns true when 3 fields to the top right are the same' do
        setup_fields [[6,2],[5,3],[4,4],[3,5]], 'x'
        board.ascending_quartet?(6,2).must_equal true
      end

      it 'returns true when 3 fields to the bottom left are the same' do
        setup_fields [[6,2],[5,3],[4,4],[3,5]], 'x'
        board.ascending_quartet?(3,5).must_equal true
      end

      it 'returns true when 1 field to the top right and 2 fields to the bottom left are the same' do
        setup_fields [[6,2],[5,3],[4,4],[3,5]], 'x'
        board.ascending_quartet?(4,4).must_equal true
      end

      it 'returns false when 2 fields to the top right are the same' do
        setup_fields [[6,2],[5,3],[4,4]], 'x'
        board.ascending_quartet?(6,2).must_equal false
      end

      it 'returns false when 2 fields to the bottom left are the same' do
        setup_fields [[5,3],[4,4],[3,5]], 'x'
        board.ascending_quartet?(3,5).must_equal false
      end

      it 'returns false when 1 field to the top right and 1 field to the bottom left are the same' do
        setup_fields [[5,3],[4,4],[3,5]], 'x'
        board.ascending_quartet?(4,4).must_equal false
      end

      it 'returns true when the 4 equal fields start in the bottom left corner' do
        setup_fields [[7,0],[6,1],[5,2],[4,3]], 'x'
        board.ascending_quartet?(7,0).must_equal true
      end

      it 'returns true when the 4 equal fields end in the top right corner' do
        setup_fields [[3,4],[2,5],[1,6],[0,7]], 'x'
        board.ascending_quartet?(0,7).must_equal true
      end

      it 'returns false when there is only one field set in the top right corner' do
        setup_fields [[0,7]], 'x'
        board.ascending_quartet?(0,7).must_equal false
      end

      it 'returns false when there is only one field set in the top left corner' do
        setup_fields [[0,0]], 'x'
        board.ascending_quartet?(0,0).must_equal false
      end

      it 'returns false when there is only one field set in the bottom right corner' do
        setup_fields [[7,7]], 'x'
        board.ascending_quartet?(7,7).must_equal false
      end
    end

    describe '#descending_quartet?' do
      it 'returns true when 3 fields to the bottom right are the same' do
        setup_fields [[2,2],[3,3],[4,4],[5,5]], 'x'
        board.descending_quartet?(2,2).must_equal true
      end

      it 'returns true when 3 fields to the top left are the same' do
        setup_fields [[2,2],[3,3],[4,4],[5,5]], 'x'
        board.descending_quartet?(5,5).must_equal true
      end

      it 'returns true when 1 field to the top left and 2 fields to the bottom right are the same' do
        setup_fields [[2,2],[3,3],[4,4],[5,5]], 'x'
        board.descending_quartet?(4,4).must_equal true
      end

      it 'returns false when 2 fields to the top right are the same' do
        setup_fields [[2,2],[3,3],[4,4]], 'x'
        board.descending_quartet?(2,2).must_equal false
      end

      it 'returns false when 2 fields to the bottom left are the same' do
        setup_fields [[3,3],[4,4],[5,5]], 'x'
        board.descending_quartet?(5,5).must_equal false
      end

      it 'returns false when 1 field to the top left and 1 field to the bottom right are the same' do
        setup_fields [[3,3],[4,4],[5,5]], 'x'
        board.descending_quartet?(4,4).must_equal false
      end

      it 'returns true when the 4 equal fields start in the top left corner' do
        setup_fields [[0,0],[1,1],[2,2],[3,3]], 'x'
        board.descending_quartet?(0,0).must_equal true
      end

      it 'returns true when the 4 equal fields end in the bottom right corner' do
        setup_fields [[4,4],[5,5],[6,6],[7,7]], 'x'
        board.descending_quartet?(7,7).must_equal true
      end

      it 'returns false when there is only one field set in the top right corner' do
        setup_fields [[0,7]], 'x'
        board.descending_quartet?(0,7).must_equal false
      end

      it 'returns false when there is only one field set in the top left corner' do
        setup_fields [[0,0]], 'x'
        board.descending_quartet?(0,0).must_equal false
      end

      it 'returns false when there is only one field set in the bottom right corner' do
        setup_fields [[7,7]], 'x'
        board.descending_quartet?(7,7).must_equal false
      end
    end
  end
end
