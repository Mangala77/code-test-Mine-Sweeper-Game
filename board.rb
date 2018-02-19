require './cell.rb'
require 'json'

class Board
    attr_accessor :field, :row_count, :col_count
    BOMB_FOUND = 1
    
    def initialize(size, json_array)
        row_count = col_count = size
        @row_count, @col_count = row_count, col_count
        #creates a default value for initialize as an array of array of blank cells
        field = Array.new(size) { Array.new(size) { Cell.new } }
        @field = field
        json_array = JSON.parse(json_array) if json_array.kind_of?(String)
        fill_board_with_bomb(json_array)
        board_display    ### can comment it for rspecs
    end
    
    def board_display
        @field.each do |line|
            print "\n"
            line.each do |cell|
                if cell.class == Cell && cell.bomb == false && cell.cleared == false
                    print " * "
                end
                if cell.bomb == false && cell.cleared == true
                    print "   "
                end
                if cell.bomb == true
                    print " B "
                end
            end
        end
        print "\n"
    end
    
    # fill board with bomb in desired location
    def fill_board_with_bomb(arr)
        arr.each do |pos|
            if pos.count == 2
                x, y = pos.first, pos.last
                @field[x][y].bomb = true
            end
        end
    end
    
    
    # Return true if the cell been uncovered, false otherwise.
    def cell_cleared?(row, col)
        if in_board?(row,col) &&  @field[row][col].cleared == true
            return true
        end
        return false
    end
    
    # Uncover the given cell. If there are no adjacent bomb to this cell
    # it should also clear any adjacent cells as well. This is the action
    # when the player clicks on the cell.
    def click(row, col)
        unless cell_cleared?(row, col)
            @field[row][col].cleared = true
            if contains_bomb?(row,col)
                puts "It was bomb"
                return BOMB_FOUND
                else
                count = adjacent_bombs(row, col)
                uncover_adjacent_cell(row, col)  if count == 0   ### extra implementation
                return count
            end
        end
    end
    
    
    def uncover_adjacent_cell(row, col)
        (-1..1).each do |i|
            (-1..1).each do |j|
                r = row + i
                c = col + j
                if r == row && c == col
                    next
                    else
                    click(r, c) if in_board?(r,c)
                end
            end
        end
    end
    
    
    # Returns the number of bomb that are surrounding this cell (maximum of 8).
    def adjacent_bombs(row, col)
        count = 0
        (-1..1).each do |i|
            (-1..1).each do |j|
                unless (i == 0 && j == 0) || (row + i) < 0 || (col + j) < 0
                    count += 1 if contains_bomb?(row + i, col + j)
                end
            end
        end
        count
    end
    
    # Returns true if the given cell contains a bomb, false otherwise.
    def contains_bomb?(row, col)
        if in_board?(row,col) && @field[row][col].bomb == true
            return true
        end
    end
    #---------------CHECK IF IN BOARD--------------#
    def in_board?(row, col)
        (row >= 0 && col >= 0) && (row <= @row_count-1 && col <= @col_count-1)
    end
    
    # Check if any cells have been uncovered that also contained a mine. This is
    # the condition used to see if the player has lost the game.
    def bomb_found?
        (0..@row_count).each do |row|
            (0..@col_count).each do |column|
                if cell_cleared?(row, column) && contains_bomb?(row, column)
                    return true
                end
            end
        end       
        return false
    end
    
    # Check if all cells that don't have mines have been uncovered. This is the
    # condition used to see if the player has won the game.
    def all_cells_cleared?
        cell_count = 0
        (0..@row_count).each do |row|
            (0..@col_count).each do |column|
                if cell_cleared?(row, column) || contains_bomb?(row, column)
                    cell_count += 1
                end
            end
        end       
        (row_count * col_count) == cell_count
    end   
end

