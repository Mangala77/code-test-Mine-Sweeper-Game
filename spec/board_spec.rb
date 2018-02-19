require 'spec_helper'

describe Board do
    input_json = "[[1,1],[3,4],[9,6]]"
    let(:board) { Board.new(10, input_json) }
    
    describe "#initialize" do
        context "with valid arguments" do
            it "assigns row_count, col_count" do
                expect(board.row_count).to  eql(10)
                expect(board.col_count).to  eql(10)
            end
            
            it "creates a multidimensional array holding cell" do
                expect(board.field).to be_an(Array)
                expect(board.field.first).to be_an(Array)
                expect(board.field.first.first).to be_a(Cell)
            end
            
            it "should fill the board coordinates with bomb" do
                expect(board.field[1][1].bomb).to eql(true)
                expect(board.field[3][4].bomb).to eql(true)
                expect(board.field[9][6].bomb).to eql(true)
            end
        end
    end
    
    describe "#cell_cleared?" do
        it "should return false if cell is not uncovered" do
            expect(board.field[1][1].cleared).to eql(false)
            expect(board.field[3][4].cleared).to eql(false)
        end
    end
    
    describe "#click" do
        it "should return true if cell has been uncovered after click" do
            board.click(1,3)
            expect(board.field[1][3].cleared).to eql(true)
        end
        
        it "should return a value when a bomb is found after click" do
            check_board = board.click(1,1)
            expect(board.field[1][1].bomb).to eql(true)
            expect(check_board).to eql(1)
        end
        
        it "should count the adjacent bomb if click is not bomb" do
            expect(board.click(3,3)).to eql(1)
        end
        
    end
    
    describe "#in_board?" do
        it "should check whether row and column is in board" do
            expect(board.in_board?(1, 1)).to eql(true)
            expect(board.in_board?(-1, 0)).to eql(false)
        end
    end
end