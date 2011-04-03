#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
    def initialize(*starting_board)
      @starting_board=starting_board
    end
    def board
      @starting_board.join 
    end
    def run(*time)
    end
  end
end
