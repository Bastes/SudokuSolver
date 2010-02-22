require 'helper'

class TestSolver < Test::Unit::TestCase
  context('Absurde problems') {
    setup {
      @problems = [
        :blah,
        "truc",
        1234,
        [ [2] ],
        [ [1], [2] ],
        [ [1, nil, nil, nil],
          [1, nil, nil, nil],
          [nil, nil, nil, nil],
          [nil, nil, nil, nil] ]
      ]
    }
    should('be impossible to solve') {
      @problems.each { |problem|
        assert_raise(SudokuSolver::InvalidProblemError) {
          SudokuSolver::Solver.solve(problem) }
      }
    }
  }

  context('The simplest problem in the world') {
    setup { @problem = [[]] }
    should('be easy to solve') {
      solution = SudokuSolver::Solver.solve(@problem)
      assert_equal [[1]], solution
    }
  }

  context('A 4x4 problem') {
    setup {
      @solution =
        [ [ 1, 2, 3, 4],
          [ 3, 4, 2, 1],
          [ 2, 1, 4, 3],
          [ 4, 3, 1, 2] ]
      @problem = @solution.collect { |l| l.clone }
    }
    context('very simple') {
      setup { @problem[0][0] = nil }
      should('still be easy to solve') {
        solved = SudokuSolver::Solver.solve(@problem)
        assert_equal @solution, solved
      }
    }
    context('simple') {
      setup {
        @problem[1][2] = nil
        @problem[2][3] = nil
      }
      should('still be easy to solve') {
        solved = SudokuSolver::Solver.solve(@problem)
        assert_equal @solution, solved
      }
    }
    context('less simple') {
      setup {
        @problem[0][2] = nil
        @problem[1][2] = nil
        @problem[2][3] = nil
        @problem[3][3] = nil
      }
      should('still be easy to solve') {
        solved = SudokuSolver::Solver.solve(@problem)
        assert_equal @solution, solved
      }
    }
    context('complex') {
      setup {
        @problem[0][2] = nil
        @problem[2][2] = nil
        @problem[0][3] = nil
        @problem[3][2] = nil
        @problem[3][1] = nil
        @problem[2][3] = nil
        @problem[2][0] = nil
        @problem[2][3] = nil
      }
      should('still be easy to solve') {
        solved = SudokuSolver::Solver.solve(@problem)
        assert_equal @solution, solved
      }
    }
  }
end
