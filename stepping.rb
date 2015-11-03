module Stepping
  def moves
    possible_moves = []
    @moves_diff.each do |pos_diff|
      move_pos = @piece_pos.dup
      move_pos[0] += pos_diff[0]
      move_pos[1] += pos_diff[1]
      possible_moves << move_pos if can_occupy?(move_pos)
    end
    return possible_moves
  end


end
