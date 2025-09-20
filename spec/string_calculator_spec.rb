require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add('')).to eq(0)
    end

    it 'returns the number itself when a single number is provided' do
      expect(StringCalculator.add('5')).to eq(5)
    end

    it 'returns the sum of two comma separated numbers' do
      expect(StringCalculator.add('1,2')).to eq(3)
    end

    it 'returns the sum of many numbers' do
      expect(StringCalculator.add('1,2,3,4')).to eq(10)
    end
    
    it 'handles newlines between numbers as delimiters' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it 'supports a custom delimiter defined like //;<newline>numbers' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it 'raises an error listing negatives when negatives are present' do
      expect { StringCalculator.add("1,-2,3,-4") }
        .to raise_error(ArgumentError, "negative numbers not allowed -2,-4")
    end

  end
end