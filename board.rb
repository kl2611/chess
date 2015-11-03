require_relative 'piece'
require 'byebug'
class Board
  attr_accessor :grid
  def initialize(grid = nil)
    @grid ||= Array.new(8) {Array.new(8)}
    # default_board
  end

  def default_board
    @grid[1].each_with_index do |piece, col_idx|
      @grid[1][col_idx] = Pawn.new("Pawn", [1, col_idx], self, {:b => "black"})
    end

    @grid[6].each_with_index do |piece, col_idx|
      @grid[6][col_idx] = Pawn.new("Pawn", [6, col_idx], self, {:w => "white"})
    end

    @grid[0][0] = Rook.new("Rook", [0, 0], self, {:b => "black"})
    @grid[0][7] = Rook.new("Rook", [0, 7], self, {:b => "black"})
    @grid[7][0] = Rook.new("Rook", [7, 0], self, {:w => "white"})
    @grid[7][7] = Rook.new("Rook", [7, 7], self, {:w => "white"})

    @grid[0][1] = Knight.new("Knight", [0, 1], self, {:b => "black"})
    @grid[0][6] = Knight.new("Knight", [0, 6], self, {:b => "black"})
    @grid[7][1] = Knight.new("Knight", [7, 1], self, {:w => "white"})
    @grid[7][6] = Knight.new("Knight", [7, 6], self, {:w => "white"})

    @grid[0][2] = Bishop.new("Bishop", [0, 2], self, {:b => "black"})
    @grid[0][5] = Bishop.new("Bishop", [0, 5], self, {:b => "black"})
    @grid[7][2] = Bishop.new("Bishop", [7, 2], self, {:w => "white"})
    @grid[7][5] = Bishop.new("Bishop", [7, 5], self, {:w => "white"})

    @grid[0][3] = Queen.new("Queen", [0, 3], self, {:b => "black"})
    @grid[7][3] = Queen.new("Queen", [7, 3], self, {:w => "white"})

    @grid[0][4] = King.new("King", [0, 4], self, {:b => "black"})
    @grid[7][4] = King.new("King", [7, 4], self, {:w => "white"})

    @kings_ref = {
      :b => @grid[0][4],
      :w => @grid[7][4]
    }

  end

  def move(start, end_pos)
    raise "Error: no piece at start position!" if @grid[start] == nil
    new_grid = replicate_board
    new_grid[end_pos] = new_grid[start]
    new_grid[start] = nil
    if valid_move?(new_grid)
      #may need to delete the eaten piece from the memory
      @grid = new_grid
      @grid[end_pos[0]][end_pos[1]].piece_pos = end_pos
    else
      raise "Error: the piece cannot move to end position!"
    end
  end

  def in_check?(side)
    king_pos = @kings_ref[side].piece_pos
    opponent_moves = []
    opponent_side_key = (side == :w) ? :b : :w
    surviving_pieces(opponent_side_key).each do |piece|
      opponent_moves.concat(piece.moves)
    end
    return opponent_moves.include?(king_pos)
  end

  def surviving_pieces(side)
    return @grid.flatten.select { |piece| piece!=nil && piece.side.keys.first == side }
  end

  def checkmate?(side)
  end

  def replicate_board
    new_grid = []
    @grid.each do |row|
      new_grid << row.dup
    end
    new_grid
  end

  def [](pos)
    x, y = pos
    return @grid[x][y]
  end

  # def []=()
  # end

  def rows
    @grid
  end

  def in_bounds?(pos)
    x , y = pos
    return x.between?(0,7) && y.between?(0,7)
  end

end

b = Board.new
b.default_board
# p b.grid[0][4].moves
# p b.grid[0][1].moves
# b.grid[6][3] = Pawn.new("Pawn", [6, 3], self, {:w => "white"})
# p b.grid[7][2].moves
b.grid[5][3] = Knight.new("Knight", [5, 3], self, {:b => "black"})
p b.in_check?(:w)
