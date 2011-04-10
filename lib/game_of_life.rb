#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
    def initialize(*starting_grid)
      @grid=starting_grid
    end
    def grid
      @grid.join("\n").gsub(/[0]/," ").gsub(/[1]/,"*")
    end
    def grid= (starting_grid)
      @grid=starting_grid
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
        alive? ? 1 : 0
      end
      def die
      end
      def born
      end
      def alive_neighbours
        [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1,0]].
         inject(0) do |sum, cell|
           sum += @grid[@x + cell[0], @y + cell[1]]
         end
      end
    end
    
    attr_reader :width, :cells 
    
    def initialize(width, cells)
      @width = width
      @cells = cells  if cells.class == Array
      r=/[\sx]{#{@width}}/
      @cells= cells.scan(r).flatten if cells.class == String  
      cells=[]
      @cells.each do |y|
        temp=[]
        y.each_char{|x| temp << ((x=="x")?1:0)}
        cells << temp
      end
      @cells = cells
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
    def run
    end
  end
end
