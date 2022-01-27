# frozen_string_literal: true

require_relative '../lib/board'

# rubocop: disable Metrics/BlockLength
describe Board do
  subject(:board) { described_class.new }

  describe '#update_board' do
    before do
      allow(board).to receive(:display_board)
      allow(board).to receive(:puts)
    end

    context 'updates the game board at location' do
      it 'updates at location 0' do
        game_board = board.instance_variable_get(:@board)
        symbol = 'X'
        location = 1
        board.update_board(symbol, location)
        expect(game_board[0]).to eq(symbol)
      end

      it 'updates at location 3' do
        game_board = board.instance_variable_get(:@board)
        symbol = 'X'
        location = 4
        board.update_board(symbol, location)
        expect(game_board[3]).to eq(symbol)
      end

      it 'updates at location 8' do
        game_board = board.instance_variable_get(:@board)
        symbol = 'X'
        location = 9
        board.update_board(symbol, location)
        expect(game_board[8]).to eq(symbol)
      end
    end

    it 'sends display_board message' do
      expect(board).to receive(:display_board).once
      board.update_board('x', 4)
    end
  end

  describe '#row_win?' do
    context 'when a row is the same symbol' do
      it 'true if the top row is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[0] = 'x'
        game_board[1] = 'x'
        game_board[2] = 'x'
        result = board.row_win?('x')
        expect(result).to eq(true)
      end

      it 'true if the mid row is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[3] = 'x'
        game_board[4] = 'x'
        game_board[5] = 'x'
        result = board.row_win?('x')
        expect(result).to eq(true)
      end

      it 'true if the bottom row is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[6] = 'x'
        game_board[7] = 'x'
        game_board[8] = 'x'
        result = board.row_win?('x')
        expect(result).to eq(true)
      end
    end

    context 'when no row is the same symbol' do
      it 'false when no symbols' do
        result = board.row_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on top row' do
        game_board = board.instance_variable_get(:@board)
        game_board[0] = 'x'
        game_board[1] = 'o'
        game_board[2] = 'x'
        result = board.row_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on mid row' do
        game_board = board.instance_variable_get(:@board)
        game_board[3] = 'x'
        game_board[4] = 'o'
        game_board[5] = 'x'
        result = board.row_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on bottom row' do
        game_board = board.instance_variable_get(:@board)
        game_board[6] = 'x'
        game_board[7] = 'x'
        game_board[8] = 'o'
        result = board.row_win?('x')
        expect(result).to eq(false)
      end
    end
  end

  describe '#column_win?' do
    context 'when a column is the same symbol' do
      it 'true if the first column is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[0] = 'x'
        game_board[3] = 'x'
        game_board[6] = 'x'
        result = board.column_win?('x')
        expect(result).to eq(true)
      end

      it 'true if the second column is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[1] = 'x'
        game_board[4] = 'x'
        game_board[7] = 'x'
        result = board.column_win?('x')
        expect(result).to eq(true)
      end

      it 'true if the third column is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[2] = 'x'
        game_board[5] = 'x'
        game_board[8] = 'x'
        result = board.column_win?('x')
        expect(result).to eq(true)
      end
    end

    context 'when no column is the same symbol' do
      it 'false when no symbols' do
        result = board.column_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on first column' do
        game_board = board.instance_variable_get(:@board)
        game_board[0] = 'x'
        game_board[3] = 'x'
        game_board[6] = 'o'
        result = board.column_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on second column' do
        game_board = board.instance_variable_get(:@board)
        game_board[1] = 'x'
        game_board[4] = 'x'
        game_board[7] = 'o'
        result = board.column_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on third column' do
        game_board = board.instance_variable_get(:@board)
        game_board[2] = 'x'
        game_board[5] = 'x'
        game_board[8] = 'o'
        result = board.column_win?('x')
        expect(result).to eq(false)
      end
    end
  end

  describe '#diagonal_win?' do
    context 'when a diagonal is the same symbol' do
      it 'true if left to right diagonal is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[0] = 'x'
        game_board[4] = 'x'
        game_board[8] = 'x'
        result = board.diagonal_win?('x')
        expect(result).to eq(true)
      end

      it 'true if right to left diagonal is the same symbol' do
        game_board = board.instance_variable_get(:@board)
        game_board[2] = 'x'
        game_board[4] = 'x'
        game_board[6] = 'x'
        result = board.diagonal_win?('x')
        expect(result).to eq(true)
      end
    end

    context 'when no diagonal is the same symbol' do
      it 'false when no symbols' do
        result = board.diagonal_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on left to right diagonal' do
        game_board = board.instance_variable_get(:@board)
        game_board[0] = 'x'
        game_board[4] = 'x'
        game_board[8] = 'o'
        result = board.diagonal_win?('x')
        expect(result).to eq(false)
      end

      it 'false when different symbols on right to left diagonal' do
        game_board = board.instance_variable_get(:@board)
        game_board[2] = 'x'
        game_board[4] = 'o'
        game_board[6] = 'x'
        result = board.diagonal_win?('x')
        expect(result).to eq(false)
      end
    end
  end

  describe '#legal_move?' do
    it 'returns true if move is legal' do
      location = 3
      expect(board.legal_move?(location)).to eq(true)
    end

    it 'returns nil if move is not legal' do
      game_board = board.instance_variable_get(:@board)
      game_board[2] = 'x'
      location = 3
      expect(board.legal_move?(location)).to be_nil
    end
  end
end
# rubocop: enable Metrics/BlockLength
