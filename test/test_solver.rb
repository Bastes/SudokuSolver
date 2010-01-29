require 'helper'

class TestSolver < Test::Unit::TestCase
  context('The simplest problem in the world') {
    setup { @problem = [[]] }
    should('be easy to solve') {
      solution = SudokuSolver::Solver.solve(@problem)
      assert_equal [[1]], solution
    }
  }

  context('A very easy problem') {
    setup {
      @solution =
        [ [ 1, 2, 3, 4],
          [ 3, 4, 2, 1],
          [ 2, 1, 4, 3],
          [ 4, 3, 1, 2] ]
      @problem = @solution.collect { |l| l.clone }
      @problem[0][0] = nil
    }
    should('still be easy to solve') {
      solved = SudokuSolver::Solver.solve(@problem)
      assert_equal @solution, solved
    }
  }
end
