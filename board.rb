require_relative 'piece'
require 'byebug'
class Board
  attr_accessor :grid, :kings_ref
  def initialize(populate_board = true)
    @grid = Array.new(8) {Array.new(8)}
    @kings_ref = {}
    default_board if populate_board
  end

  def default_board
    @grid[1].each_with_index do |piece, col_idx|
      @grid[1][col_idx] = Pawn.new("Pawn", [1, col_idx], self, :black)
    end

    @grid[6].each_with_index do |piece, col_idx|
      @grid[6][col_idx] = Pawn.new("Pawn", [6, col_idx], self, :white)
    end

    @grid[0][0] = Rook.new("Rook", [0, 0], self, :black)
    @grid[0][7] = Rook.new("Rook", [0, 7], self, :black)
    @grid[7][0] = Rook.new("Rook", [7, 0], self, :white)
    @grid[7][7] = Rook.new("Rook", [7, 7], self, :white)

    @grid[0][1] = Knight.new("Knight", [0, 1], self, :black)
    @grid[0][6] = Knight.new("Knight", [0, 6], self, :black)
    @grid[7][1] = Knight.new("Knight", [7, 1], self, :white)
    @grid[7][6] = Knight.new("Knight", [7, 6], self, :white)

    @grid[0][2] = Bishop.new("Bishop", [0, 2], self, :black)
    @grid[0][5] = Bishop.new("Bishop", [0, 5], self, :black)
    @grid[7][2] = Bishop.new("Bishop", [7, 2], self, :white)
    @grid[7][5] = Bishop.new("Bishop", [7, 5], self, :white)

    @grid[0][3] = Queen.new("Queen", [0, 3], self, :black)
    @grid[7][3] = Queen.new("Queen", [7, 3], self, :white)

    @grid[0][4] = King.new("King", [0, 4], self, :black)
    @grid[7][4] = King.new("King", [7, 4], self, :white)

    @kings_ref[:black] = @grid[0][4]
    @kings_ref[:white] = @grid[7][4]
    # p @kings_ref
  end

  # need to be re-written !!!!!!!!
  def move(start_pos, end_pos)
    raise "Error: no piece at start position!" if self[start_pos] == nil
    # new_board = self.dup
    # new_grid = new_board.grid
    # new_grid[end_pos] = new_grid[start]
    # new_grid[start] = nil
    moving_piece = self[start_pos]
    if moving_piece.valid_moves.include?(end_pos)
      self.move!(start_pos, end_pos)
    elsif self[start_pos].move_into_check?(end_pos)
      raise "Error: King will be in check!"
    else
      raise "Error: the piece cannot move to end position!"
    end
  end

  def in_check?(color)
    # p color
    # p @kings_ref
    king_pos = @kings_ref[color].piece_pos
    opponent_moves = []
    opponent_color = (color == :white) ? :black : :white
    surviving_pieces(opponent_color).each do |piece|
      opponent_moves.concat(piece.moves)
    end
    return opponent_moves.include?(king_pos)
  end

  def surviving_pieces(color)
    return @grid.flatten.select { |piece| piece != nil && piece.color == color }
  end

  def checkmate?(color)
    return in_check?(color) && valid_moves.empty?
  end

  def dup
    new_board = Board.new(false)
    new_grid = new_board.grid
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        new_grid[row_idx][col_idx] = piece.dup(new_board) unless piece == nil
      end
    end

    new_board.kings_ref[:black] = new_board[@kings_ref[:black].piece_pos]
    new_board.kings_ref[:white] = new_board[@kings_ref[:white].piece_pos]

    new_board
  end

  def [](pos)
    row_idx, col_idx  = pos
    @grid[row_idx][col_idx]
  end

  def []=(pos, value)
    row_idx, col_idx = pos
    @grid[row_idx][col_idx] = value
  end

  # def []=()
  # end

  def rows
    @grid
  end

  def in_bounds?(pos)
    row_idx, col_idx = pos
    return row_idx.between?(0,7) && col_idx.between?(0,7)
  end

  def move!(start_pos, end_pos)
    #may need to delete the eaten piece from the memory
    self[end_pos].piece_pos = nil
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].piece_pos = end_pos
  end

end

b = Board.new
# b.default_board
# g = Board.new
# g.default_board
# p b.grid[0][4].moves
# p b.grid[0][1].moves
# b.grid[6][3] = Pawn.new("Pawn", [6, 3], self, :white)
# p b.grid[7][2].moves
g = b.dup
g.grid[5][4] = Rook.new("Rook", [5, 4], g, :black)
g.grid[5][3] = Rook.new("Rook", [5, 3], g, :black)
# g.grid[5][2] = Pawn.new("Pawn", [5, 2], g, :white)
g.move([6, 4], [5, 3])
# p g.grid
# b.grid[5][3] = Knight.new("Knight", [5, 3], b, :black)
# g.grid[5][3] = Knight.new("Knight", [5, 3], g, :black)
# g.move!([5,3], [5,2])
# p g.grid[5][2].class
# p g.grid[5][3].valid_moves
# p b.grid[5][3].moves
# p b.grid[5][3].moves
# p g.grid[5][3].valid_moves
# p g.grid[5][3].moves
 # g.grid[5][3] = b.grid[5][3].dup(g)
# p g.grid[5][3].class
# p b.grid[5][3].class
# p g.in_check?(:w)
# p b.in_check?(:w)
