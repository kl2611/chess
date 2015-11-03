require_relative 'board'
require_relative 'cursorable'
require 'colorize'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @start_pos = nil
    @end_pos = nil
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
      piece ||= "  "
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif [i, j] == @start_pos
      bg = :light_blue
    elsif (i + j).odd?
      bg = :yellow
    else
      bg = :white
    end
    { background: bg, color: :white }
  end

  def render
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
