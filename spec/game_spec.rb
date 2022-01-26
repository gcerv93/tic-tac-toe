# frozen_string_literal: true

require_relative '../lib/game'

# rubocop: disable Metrics/BlockLength

describe Game do
  describe '#initialize' do
    it 'sends board message' do
      expect(Board).to receive(:new).exactly(1).times
      Game.new
    end
  end

  subject(:game) { described_class.new }

  describe '#game_loop' do
    before do
      game.instance_variable_set(:@moves, 9)
      game.instance_variable_set(:@game_board, instance_double(Board))
      game.instance_variable_set(:@current_player, instance_double(Player))
      allow(game.current_player).to receive(:player_move)
      allow(game.current_player).to receive(:player_win?)
      allow(game.game_board).to receive(:update_board)
      allow(game.game_board).to receive(:legal_move?).and_return(true)
      allow(game.current_player).to receive(:symbol).and_return('X')
    end

    it 'updates the moves variable' do
      expect{ game.game_loop }.to change { game.moves }.by(1)
      game.game_loop
    end

    it 'breaks when a player wins' do
      allow(game.current_player).to receive(:player_win?).and_return(true)
      expect(game.current_player).to receive(:congratulate_winner)
      game.game_loop
    end
  end

  describe '#game_move' do
    before do
      game.instance_variable_set(:@current_player, instance_double(Player))
      game.instance_variable_set(:@game_board, instance_double(Board))
      allow(game.current_player).to receive(:player_move).and_return(5)
      allow(game.game_board).to receive(:legal_move?).with(5).and_return(true)
    end

    it 'sends message to current_player' do
      expect(game.current_player).to receive(:player_move)
      game.game_move
    end

    it 'sends message more than once if move is not legal' do
      allow(game.game_board).to receive(:legal_move?).and_return(false, true)
      expect(game.current_player).to receive(:player_move).at_least(:twice)
      game.game_move
    end
  end

  describe '#assign_player_one' do
    before do
      game.instance_variable_set(:@player_one, instance_double(Player))
      allow(game).to receive(:gets).and_return('blue')
      allow(game).to receive(:puts)
    end

    it 'creates the player one object' do
      expect(Player).to receive(:new)
      game.assign_player_one
    end

    it 'assigns player one to current_player' do
      game.assign_player_one
      expect(game.current_player).to eq(game.player_one)
    end
  end

  describe '#assign_player_two' do
    before do
      allow(game).to receive(:gets).and_return('red')
      allow(game).to receive(:puts)
    end

    it 'creates the player two object' do
      expect(Player).to receive(:new)
      game.assign_player_two
    end
  end

  describe '#change_current_player' do
    before do
      game.instance_variable_set(:@player_one, instance_double(Player))
      game.instance_variable_set(:@player_two, instance_double(Player))
    end

    it 'returns player two when current player is player one' do
      game.instance_variable_set(:@current_player, game.player_one)
      game.change_current_player
      expect(game.change_current_player).to eq(game.player_two)
    end

    it 'returns player one when current player is player two' do
      game.instance_variable_set(:@current_player, game.player_two)
      game.change_current_player
      expect(game.change_current_player).to eq(game.player_one)
    end
  end

  describe '#ask_for_new_game' do
    before do
      allow(game).to receive(:puts)
    end

    it 'starts a new game' do
      allow(game).to receive(:gets).and_return('y')
      expect(Game).to receive(:new)
      game.ask_for_new_game
    end

    it 'says good bye' do
      allow(game).to receive(:gets).and_return('n')
      goodbye_message = "\nGood Bye!\n"
      expect(game).to receive(:puts).and_return(goodbye_message)
      game.ask_for_new_game
    end
  end
end

# rubocop: enable Metrics/BlockLength
