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
      def die
        #TODO
      end
      def born
        #TODO
      end
      def alive_neighbours
      #   [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1,0]].
      #   inject(0) do |sum, cell|
      #     sum += @grid[@x + cell[0], @y + cell[1]]
      #   end
      end
      
    end
    
    attr_reader :width, :cells 
    
    def initialize(width, cells)
      @width = width
      @cells = cells  if cells.class == Array
      r=/[\sx]{#{@width}}/
      @cells= cells.scan(r).flatten if cells.class == String  
      @height = height  
    end
    
    def height
      @cells.size
    end
    def to_s
      @cells.join
    end
    def [](x, y)
        @cells[y % @height ][x % @width]
    end
    
        
  end
  
  
end
