require_relative 'board'
require_relative 'cursorable'
require 'colorize'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @start_pos = nil
    @end_pos = nil # to be implemented later
    @selected = false
  end

  # copied from ruby-cursor-game/lib/display.rb
  #########################
  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece_class = piece.class
      piece_color = (piece == nil) ? nil : piece.color
      case [piece_class, piece_color]
        when [Pawn, :black]
          piece = "♟"
        when [Pawn, :white]
          piece = "♙"
        when [Knight, :black]
          piece = "♞"
        when [Knight, :white]
          piece = "♘"
        when [Bishop, :black]
          piece = "♝"
        when [Bishop, :white]
          piece = "♗"
        when [Rook, :black]
          piece = "♜"
        when [Rook, :white]
          piece = "♖"
        when [Queen, :black]
          piece = "♛"
        when [Queen, :white]
          piece = "♕"
        when [King, :black]
          piece = "♚"
        when [King, :white]
          piece = "♔"
        else
          piece = " "
      end
      piece = " " + piece + " "
      piece.to_s.colorize(color_options)
    end
  end

# original build_row function
  # def build_row(row, i)
  #   row.map.with_index do |piece, j|
  #     color_options = colors_for(i, j)
  #     piece = "   "
  #
  #     piece.to_s.colorize(color_options)
  #   end
  # end

# original colors_for function
  # def colors_for(i, j)
  #   if [i, j] == @cursor_pos
  #     bg = :light_red
  #   elsif [i, j] == @start_pos
  #     bg = :light_blue
  #   elsif (i + j).odd?
  #     bg = :yellow
  #   else
  #     bg = :white
  #   end
  #   { background: bg, color: :white }
  # end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif [i, j] == @start_pos
      bg = :light_blue
    elsif (i + j).odd?
      bg = :cyan
    else
      bg = :white
    end
    { background: bg, color: :black }
  end

  def render(start_pos=nil)
    @start_pos = start_pos
    system("clear")
    puts "Chess"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end
  #########################
  # copied from ruby-cursor-game/lib/display.rb

end

b = Board.new
dis = Display.new(b)
result = nil
while result.nil?
  dis.render
  result = dis.get_input
end
p result
