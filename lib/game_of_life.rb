#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
    def initialize(*starting_grid)
      @starting_grid=starting_grid
    end
    def grid
      @starting_grid.join 
    end
    def run(*time)
    end
  end
  class Grid
    attr_reader :width, :cells 
    
    def initialize(width, cells)
      @width = width
      @cells = cells       
    end
    def height
      @cells.size
    end
    
  end
  
  
end
