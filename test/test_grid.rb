require 'helper'

class TestGrid < Test::Unit::TestCase
  context('An empty 2x2 grid') {
    setup { @grid = SudokuSolver::Grid.new(2) }
    should('have the proper dimensions') {
      assert_equal 2, @grid.dimension
      assert_equal 4, @grid.width
      assert_equal 4, @grid.height
      assert_equal (0..3), @grid.size
      assert_equal (1..4), @grid.possibilities
    }
  }

  context('An empty 3x3 grid') {
    setup { @grid = SudokuSolver::Grid.new(3) }
    should('have the proper dimensions') {
      assert_equal 3, @grid.dimension
      assert_equal 9, @grid.width
      assert_equal 9, @grid.height
      assert_equal (0..8), @grid.size
      assert_equal (1..9), @grid.possibilities
    }

    context('considering one of its cells') {
      setup {
        @cell1 = @grid[2, 5]
        @cell2 = @grid.detect { |c|
          [c.x, c.y] == [2, 5] }
      }
      should('find the neighbours') {
        expected, obtained1, obtained2 = [
          [
            @grid[0, 5],
            @grid[1, 5],
            @grid[3, 5],
            @grid[4, 5],
            @grid[5, 5],
            @grid[6, 5],
            @grid[7, 5],
            @grid[8, 5],
            @grid[2, 0],
            @grid[2, 1],
            @grid[2, 2],
            @grid[2, 3],
            @grid[2, 4],
            @grid[2, 6],
            @grid[2, 7],
            @grid[2, 8],
            @grid[0, 3],
            @grid[1, 3],
            @grid[0, 4],
            @grid[1, 4]
          ],
          @cell1.neighbours,
          @cell2.neighbours
        ].collect { |a| a.sort }
        assert_equal expected, obtained1
        assert_equal expected, obtained2
      }
    }

    context('cloned') {
      setup {
        @grid[4, 4] = [1,2,3]
        @clone = @grid.dup
      }
      should("be equal") { assert_equal @grid, @clone }
      should("not be the same object") { assert_not_same @grid, @clone }
      should("evolve their own separate way") {
        @grid[1, 2] = [1, 2, 3]
        @clone[1, 2] = [5, 6, 7]
        @clone[4, 4].content.reject! { |v| v == 3 }
        assert_equal [1, 2, 3], @grid[1, 2].content
        assert_equal [1, 2, 3], @grid[4, 4].content
        assert_equal [5, 6, 7], @clone[1, 2].content
        assert_equal [1, 2], @clone[4, 4].content
        assert_not_equal @grid, @clone
      }
    }
  }

  context('An empty 4x4 grid') {
    setup { @grid = SudokuSolver::Grid.new(4) }
    should('have the proper dimensions') {
      assert_equal 4, @grid.dimension
      assert_equal 16, @grid.width
      assert_equal 16, @grid.height
      assert_equal (0..15), @grid.size
      assert_equal (1..16), @grid.possibilities
    }
    should('know it\'s not solved already') {
      assert !@grid.solved? }
  }

  context('A 2x2 grid, solved') {
    setup {
      @grid = SudokuSolver::Grid.new(2)
      problem = [ [ 1, 2, 3, 4 ],
                  [ 3, 4, 1, 2 ],
                  [ 2, 1, 4, 3 ],
                  [ 4, 3, 2, 1 ] ]
      @grid.each { |c| c.content = [problem[c.x][c.y]] }
    }
    should('know it\'s solved already') {
      assert @grid.solved? }
  }
end
