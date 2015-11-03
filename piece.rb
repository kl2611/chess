module Sliding
  # def move_dirs
  #   raise NotImplementedError
  #   #=> [[-1, 0], [0, 1]]
  # end
  def moves
    valid_moves = []
    @moves_dir.each do |dir|
      move_pos = @piece_pos.dup
      begin
        move_pos = [move_pos[0]+dir[0], move_pos[1]+dir[1]]
        valid_moves << move_pos if validate(move_pos)
      end while validate(move_pos) && @board[move_pos] == nil
    end
    return valid_moves
  end
end

module Stepping
  def moves
    valid_moves = []
    @moves_diff.each do |pos|
      pos[0] += @piece_pos[0]
      pos[1] += @piece_pos[1]
      valid_moves << pos if validate(pos)
    end
    return valid_moves
  end


end

class Piece
  attr_reader :side, :piece_name, :piece_pos, :board, :side
  def initialize(piece_name, piece_pos, board, side)
    @piece_name = piece_name
    @piece_pos = piece_pos
    @board = board
    @side = side   #:b=>black, :w=>white
  end


  #
  # def moves
  #
  # end
  def validate(pos)
    byebug
    if @board.in_bounds?(pos)==false
      return false
    elsif @board[pos] == nil || @board[pos].side != self.side
      return true
    else
      return false
    end
  end

end

class Bishop < Piece
  include Sliding
  def initialize(piece_name, piece_pos, board, side)
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
  def initialize(piece_name, piece_pos, board, side)
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
  def initialize(piece_name, piece_pos, board, side)
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
  def initialize(piece_name, piece_pos, board, side)
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
  def initialize(piece_name, piece_pos, board, side)
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
  def initialize(piece_name, piece_pos, board, side)
    super
  end

  def moves
    return []
  end

end
