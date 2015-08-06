require_relative 'board'

class Piece
  PAWN_DELTAS = [
    [1, 1],
    [1, -1]
  ]

  KING_DELTAS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
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

  def deltas
    promoted? ? KING_DELTAS : PAWN_DELTAS
  end

  def perform_slide(new_pos)
    if slide_moves.include?(new_pos)
      board.update_board(pos, new_pos)
      move_piece(new_pos)
      return true
    end
    false
  end

  def slide_moves
    row, col = pos
    s_moves = []
    deltas.each do |dr, dc|
      move = [row + (dr*move_diffs), col + (dc*move_diffs)]
      if board.on_board?(move) && board[move].nil?
        s_moves << move
      end
    end
    s_moves
  end

  def jump_moves
    row, col = pos
    j_moves = []
    deltas.each do |dr, dc|
      move = [row + (dr*move_diffs*2), col + (dc*move_diffs*2)]
      if board.on_board?(move) && board[move].nil? && captureable_opponent?(move)
        j_moves << move
      end
    end
    j_moves
  end

  # def moves
  #   slide_moves + jump_moves
  # end

  def perform_jump(new_pos)
    if moves.include?(new_pos)
      board.update_board(pos, new_pos)
      board.remove_captured(captureable_square(new_pos))
      move_piece(new_pos)
      return true
    end
    false
  end

  def move_piece(new_pos)
    self.pos = new_pos
  end

  def render
    return "b" if color == :B
    return "r" if color == :R
  end

  def captureable_square(new_pos)
    new_row, new_col = new_pos
    row, col = pos

    if new_row > row #moving down
      middle_row = row + 1
    else #moving up
      middle_row = row - 1
    end

    if new_col < col #moving left
      middle_col = col - 1
    elsif new_col > col #moving right
      middle_col = col + 1
    end

    [middle_row, middle_col]
  end

  def captureable_opponent?(new_pos)
    square = captureable_square(new_pos)
    !board[square].nil? && board[square].color != color
  end

  def move_diffs
    color == :B ? 1 : -1
  end



end
