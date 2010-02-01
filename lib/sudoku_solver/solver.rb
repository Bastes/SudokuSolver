require 'cellular_map'

module SudokuSolver
  class Solver
    def self.solve(problem)
      self.new(problem).solve
    end

    def grid
      CellularMap::Map.new[@size, @size].each { |c|
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
      self.reduce(self.grid).to_a.collect { |l| l.collect { |c|
        c.content.length == 1 ? c.content.first : nil } }
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
      grid = cell.map
      sx = cell.x - cell.x % @dimension
      sy = cell.y - cell.y % @dimension
      neighbouring_values = [
        grid[@size, cell.y],
        grid[cell.x, @size],
        grid[sx..(sx + @dimension - 1), sy..(sy + @dimension - 1)] ].
          inject([]) { |r, z| r + z.collect { |d|
            (d == cell) ? nil : d.content } }.compact.uniq
      taken = neighbouring_values.reject { |r| r.length > 1 }.flatten
      remaining = (cell.content - taken).sort
      (cell.content == remaining) || ! (cell.content = remaining)
    end
  end
end
