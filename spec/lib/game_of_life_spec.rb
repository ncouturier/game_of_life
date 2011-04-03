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
    
    it 'should keep size' do
    end
    it 'lonely cell should die' do
    end
    it 'a cell with at least 2 neighbours should live' do
    end
    it "a cell should be given birth if at least 3 neighbours" do
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
    
    it 'should be initialized without arguments' do
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
    it "should be possible to drop a cell" do
    end
    it "should be possible to detect if a cell can live" do
    end
  end

end
