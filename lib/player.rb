# frozen_string_literal: true

# class for players
class Player
  attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def player_move
    puts "#{@name}, where would you like to play?"
    location = gets.chomp until location.to_i.between?(1, 9)
    location.to_i
  end

  def player_win?(board)
    board.row_win?(symbol) || board.column_win?(symbol) || board.diagonal_win?(symbol)
  end

  def congratulate_winner
    puts "Congrats #{@name}, you win!"
  end
end
