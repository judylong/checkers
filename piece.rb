require_relative 'board'

class Piece
  DELTAS = [
    [1, 1],
    [1, -1]
  ]

  attr_accessor :pos, :color, :board
  attr_reader :promoted

  def initialize(pos, color, board)
      @pos = pos
      @color = color
      @promoted = false
      @board = board
  end

  def promoted?
    promoted
  end

  def promote
    @promoted = true
  end

  def perform_slide(new_pos)
    return false if !board.on_board?(new_pos) || !board[new_pos].nil?
    row, col = pos
    moves = DELTAS.map { |dr, dc| [row + (dr*move_diffs), col + (dc*move_diffs)]}
    valid_pos = new_pos if moves.include?(new_pos)
    board[pos] = nil
    board[valid_pos] = self
    true
  end

  def inspect
    {"p"}
  end

  def perform_jump(pos)
    return false if illegal?(pos)
    row, col = pos

    true
  end

  def move_diffs
    color == :B ? 1 : -1
  end



end
