require_relative 'board'

class Game
  attr_accessor :board, :current_player

  def initialize
    @board = Board.new
    board.fill_board
    @current_player = :B

  end

  def switch_player
  end

  def play
  end

end
