# frozen_string_literal: true

# class for board
class Board
  attr_reader :board

  def initialize
    @board = starting_board(create_board)
  end

  def create_board
    Array.new(3) { Array.new(3) }
  end

  def starting_board(created_board)
    i = 0
    created_board.map do |row|
      row.map do |_cell|
        i += 1
      end
    end
  end

  def display_board
    @board.each { |row| p row }
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
end
