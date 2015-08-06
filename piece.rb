require_relative 'board'

class Piece
  attr_accessor :pos, :color
  attr_reader :promoted

  def initialize(pos, color)
      @pos = pos
      @color = color
      @promoted = false
  end

  def promoted?
    promoted
  end

  def promote
    @promoted = true
  end

end
