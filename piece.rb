require_relative 'board'

class Piece
  attr_accessor :pos, :color

  def initialize(pos, color)
      @pos = pos
      @color = color
  end


end
