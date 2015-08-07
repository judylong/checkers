require_relative 'piece'
require 'colorize'

class Board
  SIZE = 10

  attr_accessor :grid

  def initialize
    @grid = Array.new(SIZE) { Array.new(SIZE) }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, SIZE - 1) }
  end

  def update_board(pos, valid_pos)
    self[valid_pos] = self[pos]
    self[pos] = nil
  end

  def remove_captured(captureable_square)
    self[captureable_square] = nil
  end

  def fill_board
    fill_side(:B)
    fill_side(:R)
  end

  def fill_side(color)
    start_row = color == :B ? 0 : 6
    end_row = color == :B ? 3 : 9
    grid.each_with_index do |row, row_idx|
      0.upto(row.count-1) do |col|
        if ((row_idx.even? && col.even?) || (row_idx.odd? && col.odd?)) && row_idx >= start_row
          self[[row_idx, col]] = Piece.new([row_idx, col], color, self)
        end
      end
      break if row_idx == end_row
    end
    nil
  end

  def render
    puts "  0 1 2 3 4 5 6 7 8 9"
    grid.each_with_index do |row, n|
     row_string = row.map { |square| square.nil? ? "_" : square.render.colorize(:background => :green) }.join(" ")
     puts "#{n} " + row_string
   end
   nil
  end

  def dup
    duped_board = Board.new
    grid.each_with_index do |row, row_i|
      row.each_with_index do |square, col_i|
        duped_board[[row_i, col_i]] = square.nil? ? nil : square.dup(duped_board)
      end
    end
    duped_board
  end

  def over?
    count_color(:R) == 0 || count_color(:B) == 0
  end

  def count_color(color)
    count = 0
    grid.flatten.compact.each { |piece| count += 1 if piece.color == color}
    count
  end


end
