require 'test_helper'

class ConnectFour::GameTest < ConnectFourSpec
  describe ConnectFour::Game do
    let(:game) { ConnectFour::Game.new }
    let(:board) { game.board }

    before { def game.gets; "3\n"; end } # stub user input

    it("responds to board"){ game.must_respond_to :board }

    describe "#display_board" do
      it "displays the board on the terminal" do
        proc { game.display_board }.must_output game.board.stringified
      end
    end

    describe "#prompt_for_input" do
      it "puts out player x > for x" do
        proc { game.prompt_for_input "x" }.must_output "player x >"
      end
      it "puts out player o > for o" do
        proc { game.prompt_for_input "o" }.must_output "player o >"
      end
    end

    describe "#get_input" do
      it("returns the valid input as array column (input value - 1)"){ game.get_input().must_equal 2 }
    end

    describe "#there_is_a_winner?" do
      it "is false initially" do
        game.there_is_a_winner?(2,2).must_equal false
      end
      it "is true if the just entered stone makes a quartet" do
        setup_fields [[4,0],[4,1],[4,2],[4,3]], 'x'
        game.there_is_a_winner?(4, 2).must_equal true
      end
      it "is false if the just entered stone doesn't make a quartet" do
        setup_fields [[4,0],[4,2],[4,3]], 'x'
        game.there_is_a_winner?(4, 2).must_equal false
      end
    end

    describe "#play" do
      it "displays the board and prompt for input" do
        proc { game.play 'x' }.must_output board_and_prompt_string
      end

      describe "with muted output output" do
        before do
          def game.puts x;; end
          def game.print x;; end
        end
        it "returns the row and column of the played stone as an array" do
          game.play('o').must_equal [7,2]
        end
      end

    end

    describe "#start" do
      describe "with muted output and no winner" do
        before do
          def game.there_is_a_winner? x,y;false;end
          def game.puts x;; end
          def game.print x;; end
        end
        it "finishes running after a maximum of 64 plays (8x8)" do
          game.start().must_equal 64
        end
      end
      describe "with muted output and a winner" do
        before do
          def game.there_is_a_winner? x,y;true;end
          def game.puts x;; end
          def game.print x;; end
        end
        it "finishes running" do
          game.start().must_be_nil
        end
      end
    end

  end
end
