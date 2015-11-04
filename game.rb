require_relative "board"
require_relative "display"

class Game

  def initialize()
    @board = Board.new
    @player1 = HumanPlayer.new("Kelly", :white, @board)
    @player2 = HumanPlayer.new("Colin", :black, @board)
    @current_player = @player1
  end

  def play
    until over?
      @current_player.play_turn
      switch_player!
    end
    puts "#{name} wins!"
  end

  def switch_player!
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def render

  end

  def over?
    @board.checkmate?(@current_player.color)
  end
end


class HumanPlayer
  attr_reader :name, :color

  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
    @display = Display.new(board)
  end

  def play_turn
    start_pos = nil
    end_pos = nil
    until start_pos && valid_start_pos(start_pos)?
      puts "#{@name}, select your piece on the board"
      @display.render
      start_pos = @display.get_input
    end
    until end_pos
      puts "#{@name}, where do you wanna move the piece?"
      @display.render
      end_pos = @display.get_input
    end

    return [start_pos, end_pos]
  end

  def valid_start_pos(start_pos)
    @board[start_pos] != nil && @board[start_pos].color == @color
  end
end
