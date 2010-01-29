require 'helper'

class TestSolver < Test::Unit::TestCase
  context('The simplest problem in the world') {
    setup { @problem = [[]] }
    should('be easy to solve') {
      solution = SudokuSolver::Solver.solve(@problem)
      assert_equal [[1]], solution
    }
  }
end
