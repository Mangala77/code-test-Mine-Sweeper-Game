require './board.rb'
require './cell.rb'

class Game
    
    def initialize
        @win_condition = "no"
        puts "\n \n ************ \n \n"
        puts "Welcome to Minesweeper"
        puts "New Game (n)"
        puts "Escape (e)"
        
        user_input = gets.chomp
        
        case user_input
            when "n"
            puts " Enter size of board"
            size = gets.chomp
            new_game(size.to_i)
            when "e"
            abort("Goodbye!")
            else
            puts "You're just making it up!"
        end
    end
    
    def new_game(size)
        puts "how many bomb"
        bomb = gets.chomp
        arr = []
        bomb.to_i.times do |ele|
            puts "Enter bomb location puts  [r, c]"
            user_input = gets.chomp.split(",")
            user_input.map! {|elem| elem.to_i}
            arr << user_input
        end
        @new_board = Board.new(size, arr)
        @new_board.board_display
        
        until @win_condition == "win" || @win_condition == "loss"
            puts "\n \n ************ \n \n"
            puts "Select Your Action!"
            puts "\n \n ************ \n \n"
            puts "Reveal (r)"
            puts "Adjacent Bombs(a)"
            puts "Escape (e)"
            
            user_input = gets.chomp
            
            case user_input
                when "r"
                reveal_cell
                when "a"
                count_adjacent_bombs  ### to calculate adjacent mine not for play game
                when "e"
                abort("Goodbye!")
                else
                puts "You're just making it up!"
            end
            @new_board.board_display
        end
        
    end
    
    def count_adjacent_bombs
        user_input = get_cordinates
        count = @new_board.adjacent_bombs(user_input[0], user_input[1])
        puts "Count is #{count}"
    end
    
    def reveal_cell
        user_input = get_cordinates
        @new_board.click(user_input[0], user_input[1])
        if @new_board.bomb_found?
            puts "you loss Game Over"
            @win_condition = "win"
            elsif @new_board.all_cells_cleared?
            puts "Game Won"
            @win_condition = "loss"
        end
        
    end
    
    def get_cordinates
        puts "\n \n ************ \n \n"
        puts "Enter coordinates! [r, c]"
        puts "\n \n ************ \n \n"
        
        user_input = gets.chomp.split(",")
        user_input.map! {|elem| elem.to_i}
        user_input
    end
end

Game.new       ### run the game