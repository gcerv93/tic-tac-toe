# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    it 'sends board message' do
      expect(Board).to receive(:new).exactly(1).times
      Game.new
    end
  end
end
