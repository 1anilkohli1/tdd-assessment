require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add('')).to eq(0)
    end
  end
endgit add spec/string_calculator_spec.rb
git commit -m "test: add spec for empty string (red)"
