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
        @cell = @grid[2, 5]
        @sort_order = lambda { |a, b| 2 * (a[0] <=> b[0]) + (a[1] <=> b[1]) }
      }
      should('find the neighbours') {
        expected, obtained = [
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
          @cell.neighbours
        ].collect { |a|
          a.collect { |c| [c.x, c.y, c.content] }.sort &@sort_order }
        assert_equal expected, obtained
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
  }
end
