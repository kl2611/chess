require_relative "sliding"
require_relative "stepping"

class Piece
  attr_accessor :piece_name, :piece_pos, :board, :color
  def initialize(piece_name, piece_pos, board, color)
    @piece_name = piece_name
    @piece_pos = piece_pos
    @board = board
    @color = color   #:black or :white
  end

  def valid_moves
    all_valid_moves = moves
    return all_valid_moves.select do |pos|
      move_into_check?(pos) == false
    end
  end

  def move_into_check?(pos)
    # return false
    temp_board = @board.dup

  end

  def dup(new_board)
    return self.class.new(@piece_name, @piece_pos, new_board, @color)
  end
  #
  # def moves
  #
  # end
  def can_occupy?(pos)
    if @board.in_bounds?(pos) == false
      return false
    elsif @board[pos] == nil || @board[pos].color != self.color
      return true
    else
      return false
    end
  end

end

class Bishop < Piece
  include Sliding
  def initialize(*_args)
    @moves_dir = [
    [1, 1],
    [1, -1],
    [-1, -1],
    [-1, 1]
    ]
    super
  end

end

class Rook < Piece
  include Sliding
  def initialize(*_args)
    @moves_dir = [
    [0, 1],
    [1, 0],
    [0, -1],
    [1, 0]
    ]
    super
  end
end

class Queen < Piece
  include Sliding
  def initialize(*_args)
    @moves_dir = [
    [0, 1],
    [1, 0],
    [0, -1],
    [-1, 0],
    [1, 1],
    [1, -1],
    [-1, -1],
    [-1, 1]
    ]
    super
  end
end

class Knight < Piece
  include Stepping
  def initialize(*_args)
    @moves_diff = [
    [1, 2],
    [1, -2],
    [-1, -2],
    [-1, 2],
    [2, 1],
    [2, -1],
    [-2, -1],
    [-2, 1],
  ]
    super
  end
end

class King < Piece
  include Stepping
  def initialize(*_args)
    @moves_diff = [
    [1, 0],
    [1, 1],
    [1, -1],
    [0, 1],
    [-1, 0],
    [-1, 1],
    [-1, -1],
    ]
    super
  end
end

class Pawn < Piece
  def initialize(*_args)
    super
    if @color == :black
      @capture_diff = [
        [1, 1],
        [1, -1]
      ]
      @advance_diff = [
        [1, 0],
        [2, 0]
      ]
    else
      @capture_diff = [
        [-1, 1],
        [-1, -1]
      ]
      @advance_diff = [
        [-1, 0],
        [-2, 0]
      ]
    end
  end

  def moves
    return []
  end

end
