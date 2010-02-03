require 'cellular_map'

module SudokuSolver
  module Cell
    attr_accessor :grid

    def neighbours
      sx = x - x % grid.dimension
      sy = y - y % grid.dimension
      neighbours_values = [
        grid[grid.size, y],
        grid[x, grid.size],
        grid[sx..(sx + grid.dimension - 1), sy..(sy + grid.dimension - 1)] ].
          inject([]) { |r, z| r + z.to_a }.flatten.uniq.reject { |d| d == self }
    end
  end

  class Grid < CellularMap::Zone
    attr_reader :dimension, :size, :possibilities

    def initialize(dimension)
      @dimension = dimension
      @width = @dimension ** 2
      @size = (0..(@width - 1))
      @possibilities = (1..@width)
      super(@size, @size, CellularMap::Map.new)
    end

    def [](x, y)
      cell = super
      if cell.is_a? CellularMap::Cell
        cell.extend Cell
        cell.grid = self
      end
      cell
    end

    protected

    def initialize_copy(other) # :nodoc:
      @map = other.map.dup
      @map.each { |c|
        c.content = c.content.dup rescue nil
        c.content = nil unless x === c.x && y === c.y
      }
    end
  end
end
