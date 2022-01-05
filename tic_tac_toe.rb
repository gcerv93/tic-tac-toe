# frozen_string_literal: true

# class for board
class Board
  attr_reader :board

  def initialize
    @board = starting_board(create_board_array)
  end

  def create_board_array
    Array.new(3) { Array.new(3) }
  end

  def starting_board(board_array)
    i = 0
    board_array.map do |row|
      row.map do |_cell|
        i += 1
      end
    end
  end

  def display_board
    puts "\n"
    board.each { |row| p row }
    puts "\n"
  end

  def update_board(symbol, location)
    if location <= 3
      board[0][location - 1] = symbol
    elsif location <= 6 && location >= 4
      board[1][location - 4] = symbol
    else
      board[2][location - 7] = symbol
    end
    display_board
  end
end

# class for players
class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# game loop class
class Game
  attr_reader :game_board

  def initialize
    @game_board = Board.new
  end

  def game_loop; end

  def start_game; end
end
