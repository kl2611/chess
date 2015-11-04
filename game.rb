require_relative "board"
require_relative "display"

class Game

  def initialize()
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new("Kelly", :white, @board, @display)
    @player2 = HumanPlayer.new("Colin", :black, @board, @display)
    @current_player = @player1

  end

  def play
    until over?
      @current_player.play_turn
      switch_player!
    end

    switch_player!
    message = "#{@current_player.name} wins!"
    end_of_game_render(message)
  end

  def switch_player!
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def end_of_game_render(message)
    @display.render(message, nil, nil)
  end

  def over?
    @board.checkmate?(@current_player.color)
  end
end


class HumanPlayer
  attr_reader :name, :color

  def initialize(name, color, board, display)
    @name = name
    @color = color
    @board = board
    @display = display
  end

  def play_turn
    begin
      start_pos = nil
      end_pos = nil
      until start_pos && valid_start_pos(start_pos)
        message = "#{@name}, select your piece on the board"
        # message += "Invalid selection! " unless start_pos != nil && valid_start_pos(start_pos)
        @display.render(message)
        start_pos = @display.get_input

      end
      until end_pos
        message = "#{@name}, where do you wanna move the piece?"
        @display.render(message, start_pos)
        end_pos = @display.get_input
      end
      @board.move(start_pos, end_pos)
    rescue MoveError => e
      puts e.message
      retry
    end
  end
    # return [start_pos, end_pos]


  def valid_start_pos(start_pos)
    p start_pos
    p @board[start_pos] != nil
    # p @board[start_pos].color == @color
    @board[start_pos] != nil && @board[start_pos].color == @color
  end
end

game = Game.new
game.play
