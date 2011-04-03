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
    class Cell
      attr_reader :x, :y
      def initialize(grid, x, y, status)
           @grid = grid
           @x, @y = x, y
           @status = status
      end
      def alive?
            @status == 1
      end
      def to_s
           alive? ? "x" : " "
      end
    end
    attr_reader :width, :cells 
    
    def initialize(width, cells)
      @width = width
      @cells = cells  if cells.class == Array
      r=/[\sx]{#{@width}}/
      @cells= cells.scan(r).flatten if cells.class == String    
    end
    
    def height
      @cells.size
    end
    def to_s
      @cells.join
    end
        
  end
  
  
end
