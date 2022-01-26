# frozen_string_literal: true

require './lib/board'
require './lib/player'

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
    puts "\nWelcome to Tic-Tac-Toe!\n\n"
    assign_player_one
    assign_player_two
    game_board.display_board
    game_loop
    tie_message if moves == 10
    ask_for_new_game
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

  def ask_for_new_game
    puts "\nWould you like to play a new game? [Y/N]"
    answer = gets.chomp
    answer = gets.chomp until answer.downcase == 'y' || answer.downcase == 'n'
    if answer.downcase == 'y'
      Game.new
    else
      puts "\nGood Bye!"
    end
  end
end
