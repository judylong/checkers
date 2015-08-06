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

  def get_move
    puts "Enter a move or move sequence as a list of space separated, bracketed positions. "
    puts "(the first position will be the piece you want to move): "
    gets.chomp
  end

  def parse(input)
    string_sequence = string_sequence.split(".").map(&:strip)
    seq = string_sequence.map{|arr| arr[1...-1].split(",").map(&:to_i)}
  end
end
