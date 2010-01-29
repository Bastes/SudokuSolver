require 'cellular_map'

module SudokuSolver
  module Solver
    def self.solve(problem)
      width = problem.length
      dimension = Math.sqrt(width).to_i
      size = (0..(width -1))
      possibilities = (1..width)
      grid = CellularMap::Map.new[size, size]
      grid.each { |c|
        v = problem[c.x][c.y]
        c.content = v ? [v] : (1..width).to_a
      }
      self.reduce(grid, width, dimension, possibilities, size).
        to_a.collect { |l| l.collect { |c| c.content.first } }
    end

    protected

    def self.reduce(grid, width, dimension, possibilities, size)
      grid.each { |c|
        sx = c.x / dimension
        sy = c.y / dimension
        neighbouring_values = [
          grid[size, c.y],
          grid[c.x, size],
          grid[sx..(sx + dimension - 1), sy..(sy + dimension - 1)] ].
            inject([]) { |r, z| r + z.collect { |d|
              (d == c) ? nil : d.content } }.compact.uniq
        taken = neighbouring_values.reject { |r| r.length > 1 }.flatten
        remaining = c.content - taken
        c.content = remaining
      }
    end
  end
end
