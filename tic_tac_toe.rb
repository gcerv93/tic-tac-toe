# frozen_string_literal: true

# class for board
class Board
  def initialize
    @board = Array.new(3) { Array.new(3) { '' } }
  end

  def display_board
    @board.each { |row| p row }
  end
end
