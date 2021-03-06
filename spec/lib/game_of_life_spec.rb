require 'spec_helper'
require 'game_of_life'

describe GameOfLife::Game do
  before(:all) do
    # testing data:
    # http://fr.wikipedia.org/wiki/Fichier:Gospers_glider_gun.gif
    # http://commons.wikimedia.org/wiki/File:Game_of_life_glider_gun.png
    @starting_grid  = "                        x           \n"
    @starting_grid += "                      x x           \n"
    @starting_grid += "            xx      xx            xx\n"
    @starting_grid += "           x   x    xx            xx\n"
    @starting_grid += "xx        x     x   xx              \n"
    @starting_grid += "xx        x   x xx    x x           \n"
    @starting_grid += "          x     x       x           \n"
    @starting_grid += "           x   x                    \n"
    @starting_grid += "            xx                      \n"
    @starting_grid += "                                    \n" * 27

    @after_one_turn  = nil

    @after_five_turn = nil
    @width = 36
    @cells = @starting_grid.split(/\n/)
  end

  before(:each) do
    @game = GameOfLife::Game.new(@starting_grid)
  end
  describe  "Game" do
    it 'should be initialized without arguments' do
      lambda { GameOfLife::Game.new }.should_not raise_error
    end
    it 'should be initialized with arguments' do
      lambda { GameOfLife::Game.new(@starting_grid) }.should_not raise_error
    end
    it 'should respond to board' do
      @game.should respond_to(:grid)
    end
    it '#board should return starting board after initializazion' do
      @game = GameOfLife::Game.new(@starting_grid)
      @game.grid.should == @starting_grid
    end
    it 'should respond to run' do
      @game.should respond_to(:run)
    end
    it '#run should accept no argument' do
      lambda { @game.run }.should_not raise_error
    end
    it '#run should accept a numeric argument' do
      lambda { @game.run(5) }.should_not raise_error
    end
    
    it 'should run game for one round' do
      @game.run
      @game.grid == @after_one_turn
    end
    it 'should run game for five round' do
      @game.run(5)
      @game.grid == @after_five_turn
    end
    
    
    
    describe "misc" do
      it 'should print board' do
        @game.grid.to_s.should == @starting_grid
      end
    end
  end
    
  describe "grid" do
    before(:each) do
      @grid = GameOfLife::Grid.new(@width, @cells)
    end
    
    it 'should not be initialized without arguments' do
      lambda { GameOfLife::Grid.new }.should raise_error
    end
    it 'should be initialized with arguments' do
      lambda { GameOfLife::Grid.new(@width, @cells) }.should_not raise_error
    end
    it 'should respond to height' do
      @grid.should respond_to(:height)
    end
    it 'height should be 36' do
      @grid.height.should == 36
    end
    it "should respond to to_s" do
      @grid.should respond_to(:to_s)
    end
    it "should have coherent sizes and content" do
        @grid1 = GameOfLife::Grid.new(3, [" x "," x "," x "])
        @cells = " x  x  x "
        @grid2 = GameOfLife::Grid.new(3, @cells)
        @grid1.height.should == 3
        @grid1.width.should == 3
        @grid2.height.should == 3
        @grid2.width.should == 3
        @grid2.cells.should == @grid1.cells
    end
    it "should have coherent sizes and content for different grid" do
        @grid1 = GameOfLife::Grid.new(3, [" x "," x "," x "])
        @grid2 = GameOfLife::Grid.new(3, [" x "," x "," x "])
        @grid3 = GameOfLife::Grid.new(4, [" x "," x "," x "," x "])
        @grid4 = GameOfLife::Grid.new(4, ["   "," x "," x "," x "])
        
        @grid1.cells.should == @grid2.cells
        @grid1.cells.should_not == @grid3.cells
        @grid1.cells.should_not == @grid4.cells
        @grid3.cells.should_not == @grid4.cells
    end
    it "should be run" do
      @grid.should respond_to(:run)
    end
    it 'should keep size' do
      @grid1= @grid.run
      @grid1.size.should == @grid.height
    end
    it 'lonely cell should die' do
       @grid = GameOfLife::Grid.new(3, ["   "," x ","   "])
       @grid.run
       @grid[1,1].should == 0
    end
    it 'a cell with at least 2 neighbours should live' do
        @grid = GameOfLife::Grid.new(3, [" x "," xx","   "])
        @grid.run
        @grid[1,0].should == 1
    end
    it "a cell should be given birth if at least 3 neighbours" do
       @grid = GameOfLife::Grid.new(3, [" x "," xx","   "])
       @grid.run
       @grid[2,0].should == 1
    end
    it "a cell should die if at least 4 neighbours" do
         @grid = GameOfLife::Grid.new(3, [" xx","xxx","   "])
         @grid.run
         @grid[1,1].should == 0
    end
    
    describe  "cell" do 
      before(:each) do
          @grid = GameOfLife::Grid.new(3, [" x "," x "," x "])
      end
      it "should be possible to drop a cell" do
         lambda {GameOfLife::Grid::Cell.new(@grid,1,1,1)}.should_not raise_error
      end
      describe  "cell behaviour" do
        before(:each) do
           @cell = GameOfLife::Grid::Cell.new(@grid,1,1,1)
        end
        it 'should respond to to_s' do
            @cell.should respond_to(:to_s)
        end
        it "should be giving a 1" do
             @cell.to_s.should == 1 
        end
        it 'should respond to alive?' do
              @cell.should respond_to(:alive?)
        end
        it "should be alive" do
               @cell.alive?.should == true 
        end
        it 'should respond to die' do
            @cell.should respond_to(:die)
        end
        it 'should respond to born' do
            @cell.should respond_to(:born)
        end
        
        it "can be returned by a grid" do
          @grid.should respond_to(:[])
          @grid[0,0].should == 0
          @grid[1,1].should == 1
          @grid[0,1].should == 0
          @grid[1,0].should == 1
        end
        it 'should respond to alive_neighbours' do
          @cell.should respond_to(:alive_neighbours)
        end
        it 'should respond to alive_neighbours' do
          @cell.alive_neighbours.should == 2
          @cell = GameOfLife::Grid::Cell.new(@grid,0,1,0)
          @cell.alive_neighbours.should == 3
        end
      end
    end     
    
  end

end
