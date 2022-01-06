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

  def row_win?
    board.each do |row|
      return true if row.uniq.length == 1
    end
    false
  end

  def column_win?(symbol)
    flat = board.flatten
    flat.values_at(0, 3, 6).all? { |sym| sym == symbol } ||
      flat.values_at(1, 4, 7).all? { |sym| sym == symbol } ||
      flat.values_at(2, 5, 8).all? { |sym| sym == symbol }
  end

  def diagonal_win?(symbol)
    flat = board.flatten
    return flat[0] == symbol && flat[8] == symbol || flat[2] == symbol && flat[6] == symbol if flat[4] == symbol
  end
end

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
end

# game loop class
class Game
  attr_reader :game_board, :player_one, :player_two

  def initialize
    @game_board = Board.new
    start_game
  end

  def game_loop; end

  def start_game
    puts "Welcome to Tic-Tac-Toe!\n\n"
    assign_player_one
    assign_player_two
    game_board.display_board
  end

  def assign_player_one
    puts 'Player one, enter your name: '
    @player_one = Player.new(gets.chomp, 'X')
    puts "\n"
  end

  def assign_player_two
    puts 'Player two, enter your name: '
    @player_two = Player.new(gets.chomp, 'O')
  end

  def game_turn
    game_board.update_board(player_one.symbol, player_one.player_move)
    game_board.update_board(player_two.symbol, player_two.player_move)
  end
end
