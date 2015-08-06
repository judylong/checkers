require_relative 'piece'

class Board
  SIZE = 8

  attr_accessor :grid

  def initialize
    @grid = Array.new(SIZE) { Array.new(SIZE) }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, obj)
    row, col = pos
    grid[row][col] = obj
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, SIZE - 1) }
  end
end
