Welcome to Mine Sweeper Game.

Implement a TDD solution for a MineSweeper board logic management.

Using the so famous Minesweeper game (http://minesweeperonline.com/), build the board
management logic.

We would like you to provide two functions for a UI developer to call.

1. A board initialisation function, this will receive two arguments:

   a. Size: Is the number of cells on each side of the board (squared). For example
    if the number 5 were passed this would mean build a board which is 5x5 in
     size.

   b. Bombs: An array of values indicating where the bombs should be placed in
       on the board. For example this could be an array of pairs with x, y
        co­ordinates, such as (in json):

          “[[1,1], [3,4], [9,6]]”

         This would mean places bombs in cells
                  1,1

                  3,4

                  9,6


2. A function to be called when the user clicks on a cell, this should return a
value/values indicating whether the cell was a bomb, and if not how many bombs are
in the spaces directly surrounding the cell.



Building and running
------------------------

For temporary run we can use game.rb though not fully well organised but for testing user view.

run

1. ruby game.rb.


Rspec writeen only for main methods, intialise and filling the bomb and click method.

run the rspecs

2. rspec spec/board_spec.rb 


Thank you
