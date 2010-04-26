require 'helper'

class TestSolver < Test::Unit::TestCase
  [ :blah,
    "truc",
    1234,
    [ [2] ],
    [ [1], [2] ],
    [ [1, nil, nil, nil],
      [1, nil, nil, nil],
      [nil, nil, nil, nil],
      [nil, nil, nil, nil] ] ].each { |problem|
    context("This absurd problem #{problem.inspect}") {
      should('be impossible to solve') {
        assert_raise(SudokuSolver::InvalidProblemError) {
          SudokuSolver::Solver.solve(problem) }
      }
    }
  } 

  { [[nil]] => [[1]] }.each { |problem, solution|
    context("The simplest problem in the world #{problem}") {
      should('be easy to solve') {
        assert_equal solution, SudokuSolver::Solver.solve(problem)
      }
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
        assert_equal @solution, SudokuSolver::Solver.solve(@problem)
      }
    }
    context('simple') {
      setup {
        @problem[1][2] = nil
        @problem[2][3] = nil
      }
      should('still be easy to solve') {
        assert_equal @solution, SudokuSolver::Solver.solve(@problem)
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
        assert_equal @solution, SudokuSolver::Solver.solve(@problem)
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
        assert_equal @solution, SudokuSolver::Solver.solve(@problem)
      }
    }
  }

  context("And now it's 3x3 time !") {
    context("Easy for a start") {
      setup {
        @problem =
          [ [   7, nil, nil,   3, nil, nil, nil,   2, nil ],
            [   8,   4, nil,   2,   6, nil, nil, nil,   5 ],
            [ nil,   5,   2, nil,   1,   9, nil,   8,   7 ],
            [ nil, nil, nil,   9, nil, nil, nil,   3,   2 ],
            [   4, nil,   1, nil, nil, nil,   7, nil,   6 ],
            [   9,   2, nil, nil, nil,   6, nil, nil, nil ],
            [   2,   9, nil,   6,   8, nil,   1,   7, nil ],
            [   1, nil, nil, nil,   2,   4, nil,   6,   8 ],
            [ nil,   7, nil, nil, nil,   3, nil, nil,   4 ] ]
        @solution =
          [ [   7,   1,   6,   3,   5,   8,   4,   2,   9 ],
            [   8,   4,   9,   2,   6,   7,   3,   1,   5 ],
            [   3,   5,   2,   4,   1,   9,   6,   8,   7 ],
            [   5,   6,   7,   9,   4,   1,   8,   3,   2 ],
            [   4,   8,   1,   5,   3,   2,   7,   9,   6 ],
            [   9,   2,   3,   8,   7,   6,   5,   4,   1 ],
            [   2,   9,   4,   6,   8,   5,   1,   7,   3 ],
            [   1,   3,   5,   7,   2,   4,   9,   6,   8 ],
            [   6,   7,   8,   1,   9,   3,   2,   5,   4 ] ]
      }
      should("be easy to solve") {
        assert_equal @solution, SudokuSolver::Solver.solve(@problem)
      }
    }
    context("And now a hard one") {
      setup {
        @problem =
          [ [   9, nil, nil,   3, nil, nil, nil, nil,   6 ],
            [ nil,   8, nil, nil, nil, nil, nil, nil,   7 ],
            [ nil, nil,   5,   2, nil,   8,   9, nil, nil ],
            [ nil, nil,   8, nil, nil,   4, nil,   7,   3 ],
            [ nil,   9, nil, nil, nil, nil, nil,   4, nil ],
            [   7,   6, nil,   1, nil, nil,   2, nil, nil ],
            [ nil, nil,   7,   8, nil,   1,   4, nil, nil ],
            [   1, nil, nil, nil, nil, nil, nil,   5, nil ],
            [   8, nil, nil, nil, nil,   9, nil, nil,   1 ] ]
        @solution =
          [ [   9,   2,   1,   3,   4,   7,   5,   8,   6 ],
            [   4,   8,   6,   9,   1,   5,   3,   2,   7 ],
            [   3,   7,   5,   2,   6,   8,   9,   1,   4 ],
            [   2,   1,   8,   5,   9,   4,   6,   7,   3 ],
            [   5,   9,   3,   6,   7,   2,   1,   4,   8 ],
            [   7,   6,   4,   1,   8,   3,   2,   9,   5 ],
            [   6,   5,   7,   8,   2,   1,   4,   3,   9 ],
            [   1,   4,   9,   7,   3,   6,   8,   5,   2 ],
            [   8,   3,   2,   4,   5,   9,   7,   6,   1 ] ]
      }
      should("be easy to solve") {
        assert_equal @solution, SudokuSolver::Solver.solve(@problem)
      }
    }
  }
end
