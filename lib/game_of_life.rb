#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
    def initialize(*starting_grid)
        @starting_grid=starting_grid[0]
    end
    def grid
      if @grid.nil?
          @starting_grid
      else
          @grid.cells.collect{|l|l.join}.join("\n").gsub(/[0]/," ").gsub(/[1]/,"*")
      end
    end
    def grid=(starting_grid)
      @starting_grid=starting_grid
    end
    def run(*time)
        @grid=Grid.new(@starting_grid.lines.to_a.first.length, @starting_grid)
        if time==[]
          @grid.run
        else
          time[0].times do |variable|
            @grid.run
          end
        end
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
        @grid[@x, @y] = 0
      end
      def born
        @grid[@x, @y] = 1
      end
      def unchanged
        @grid[@x, @y] = @status
      end
      def alive_neighbours
        [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1,0]].
         inject(0) do |sum, cell|
           sum += @grid[@x + cell[0], @y + cell[1]]
         end
      end
    end
    
    attr_reader :width, :height, :cells 
    
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
      @height = @cells.size
    end
    
    def [](x, y)
        @cells[y % @height ][x % @width]
    end
    def []=(x, y, value)
       @next[y % @height][x % @width] = value
    end
    def each(&blk)
        @cells.each_with_index do |row, y|
          row.each_with_index { |col, x| yield Cell.new(self, x, y, self[x,y]) }
        end
    end
    def run
      @next = Array.new(@height).map { Array.new(@width)}
      each do |cell|
            if cell.alive?
              (cell.alive_neighbours < 2 || cell.alive_neighbours > 3) ?
      cell.die : cell.unchanged
            else
              cell.alive_neighbours == 3 ? cell.born : cell.unchanged
            end
      end
      @cells = @next
    end
    def cells
      @cells
    end
  end
end
