# frozen_string_literal: true

# class for board
class Board
  attr_reader :board, :new_board

  def initialize
    @board = Array.new(9) { |n| n + 1 }
  end

  # rubocop:disable Metrics/AbcSize
  def display_board
    puts "\n
    #{board[0]} | #{board[1]} | #{board[2]}
    --+---+--
    #{board[3]} | #{board[4]} | #{board[5]}
    --+---+--
    #{board[6]} | #{board[7]} | #{board[8]}
    \n"
  end
  # rubocop:enable Metrics/AbcSize

  def update_board(symbol, location)
    board[location - 1] = symbol
    display_board
  end

  def row_win?(symbol)
    board[0..2].all? { |sym| sym == symbol } ||
      board[3..5].all? { |sym| sym == symbol } ||
      board[6..8].all? { |sym| sym == symbol }
  end

  def column_win?(symbol)
    board.values_at(0, 3, 6).all? { |sym| sym == symbol } ||
      board.values_at(1, 4, 7).all? { |sym| sym == symbol } ||
      board.values_at(2, 5, 8).all? { |sym| sym == symbol }
  end

  def diagonal_win?(symbol)
    board.values_at(0, 4, 8).all? { |sym| sym == symbol } ||
      board.values_at(2, 4, 6).all? { |sym| sym == symbol }
  end

  def legal_move?(location)
    return true if board[location - 1].is_a?(Numeric)
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

  def player_win?(board)
    board.row_win?(symbol) || board.column_win?(symbol) || board.diagonal_win?(symbol)
  end

  def congratulate_winner
    puts "Congrats #{@name}, you win!"
  end
end

# game loop class
class Game
  attr_reader :game_board, :player_one, :player_two, :moves, :current_player

  def initialize
    @game_board = Board.new
    @moves = 1
    start_game
  end

  def game_loop
    while @moves <= 9
      move = game_move
      game_board.update_board(current_player.symbol, move)
      if current_player.player_win?(game_board)
        current_player.congratulate_winner
        break
      end
      @current_player = change_current_player
      @moves += 1
    end
  end

  def game_move
    move = current_player.player_move
    move = current_player.player_move until game_board.legal_move?(move)
    move
  end

  def start_game
    puts "Welcome to Tic-Tac-Toe!\n\n"
    assign_player_one
    assign_player_two
    game_board.display_board
    game_loop
    tie_message if moves == 10
  end

  def assign_player_one
    puts 'Player one, enter your name: '
    @player_one = Player.new(gets.chomp, 'X')
    @current_player = player_one
    puts "\n"
  end

  def assign_player_two
    puts 'Player two, enter your name: '
    @player_two = Player.new(gets.chomp, 'O')
  end

  def change_current_player
    current_player == player_one ? player_two : player_one
  end

  def tie_message
    puts "It's a tie, no one won :("
  end
end
