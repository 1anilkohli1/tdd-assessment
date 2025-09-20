require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add('')).to eq(0)
    end

    it 'returns the number itself when a single number is provided' do
      expect(StringCalculator.add('5')).to eq(5)
    end
  end
end