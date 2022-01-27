# frozen_string_literal: true

require_relative '../lib/player'

# rubocop: disable Metrics/BlockLength

describe Player do
  subject(:player) { described_class.new('doobie', 'X') }

  describe '#player_move' do
    before do
      allow(player).to receive(:puts)
    end

    context 'when given valid input' do
      it 'accepts correct input' do
        valid_input = '5 '
        allow(player).to receive(:gets).and_return(valid_input)
        location = player.player_move
        expect(location).to eq(5)
      end
    end

    context 'when given incorrect input' do
      it 'does not accept incorrect input' do
        wrong_input = '10 '
        allow(player).to receive(:gets).and_return(wrong_input, '11 ', '7 ')
        expect(player).to receive(:gets).at_least(2).times
        player.player_move
      end

      it 'calls get until input is valid' do
        allow(player).to receive(:gets).and_return('10 ', '11 ', '16 ', '5 ')
        location = player.player_move
        expect(location).to eq(5)
      end
    end
  end

  subject(:board) { instance_double(Board) }
  describe '#player_win?' do
    context 'sends messages' do
      it 'sends row_win message to board' do
        allow(board).to receive(:row_win?).and_return(true)
        expect(board).to receive(:row_win?)
        player.player_win?(board)
      end

      it 'sends column_win message to board' do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(true)
        expect(board).to receive(:column_win?)
        player.player_win?(board)
      end

      it 'sends diagonal_win message to board' do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(false)
        allow(board).to receive(:diagonal_win?).and_return(true)
        expect(board).to receive(:diagonal_win?).once
        player.player_win?(board)
      end
    end

    context "when there's a win" do
      it 'returns true if theres a row_win' do
        allow(board).to receive(:row_win?).and_return(true)
        result = player.player_win?(board)
        expect(result).to eq(true)
      end

      it "returns true if there's a column_win" do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(true)
        result = player.player_win?(board)
        expect(result).to eq(true)
      end

      it "returns true if there's a diagonal_win" do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(false)
        allow(board).to receive(:diagonal_win?).and_return(true)
        result = player.player_win?(board)
        expect(result).to eq(true)
      end
    end

    context "when there's no wins" do
      it 'returns false' do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(false)
        allow(board).to receive(:diagonal_win?).and_return(false)
        result = player.player_win?(board)
        expect(result).to eq(false)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
