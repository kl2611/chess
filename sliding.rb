module Sliding
  # def move_dirs
  #   raise NotImplementedError
  #   #=> [[-1, 0], [0, 1]]
  # end
  def moves
    possible_moves = []
    @moves_dir.each do |dir|
      move_pos = @piece_pos.dup
      begin
        move_pos = [move_pos[0] + dir[0], move_pos[1] + dir[1]]
        possible_moves << move_pos if validate(move_pos)
      end while can_occupy?(move_pos) && @board[move_pos].nil?
    end
    possible_moves
  end
end
