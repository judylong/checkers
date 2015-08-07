require_relative 'board'

class Game
  attr_accessor :board, :current_player

  def initialize
    @board = Board.new
    board.fill_board
    @current_player = :B

  end

  def switch_player
    self.current_player = current_player == :B ? :W : :B
  end

  def play
    board.render
    until board.over?
      puts "#{current_player}'s turn: "
      input = get_move

      seq = parse(input)
      raise InvalidMoveError if !board.on_board?(seq[0]) ||
                    board[seq[0]].nil? || board[seq[0]].color != current_player
      board[seq[0]].perform_moves(*seq.drop(1))
      board.render
      switch_player
    end
  end

  def get_move
    puts "Enter a move or move sequence as a list of space separated, bracketed positions. "
    puts "(the first position will be the piece you want to move): "
    gets.chomp
  end

  def parse(input)
    string_sequence = input.split(" ").map(&:strip)
    seq = string_sequence.map { |arr| arr[1...-1].split(",").map(&:to_i) }
  end
end
