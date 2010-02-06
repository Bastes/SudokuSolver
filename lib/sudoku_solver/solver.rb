require 'sudoku_solver/grid'

module SudokuSolver
  class Solver
    def self.solve(problem)
      self.new(problem).solve
    end

    def grid
      Grid.new(@dimension).each { |c|
        v = @problem[c.y][c.x]
        c.content = v ? [v] : @possibilities.to_a
      }
    end

    def initialize(problem)
      @problem = problem
      @width = @problem.length
      @dimension = Math.sqrt(@width).to_i
      @size = (0..(@width -1))
      @possibilities = (1..@width)
    end

    def solve
      self.step(self.grid).to_a.collect { |l| l.collect { |c|
        c.content.length == 1 ? c.content.first : nil } }
    end

    def step(grid)
      grid = self.reduce(grid)
    end

    def reduce(grid)
      unsolved = grid.reject { |c| c.content.length == 1 }
      until unsolved.empty? do
        changed = unsolved.reject { |c| restrict(c) }
        break unless changed.length > 0
        unsolved.reject! { |c| c.content.length == 1 }
      end
      grid
    end

    def restrict(cell)
      taken = cell.neighbours.collect { |c| c.content }.
        reject { |r| r.length > 1 }.flatten
      remaining = (cell.content - taken).sort
      (cell.content == remaining) || ! (cell.content = remaining)
    end
  end
end
