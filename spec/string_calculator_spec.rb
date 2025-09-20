require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    context 'when input is empty or nil' do
      it 'returns 0 for an empty string' do
        expect(StringCalculator.add('')).to eq(0)
      end

      it 'returns 0 for nil input' do
        expect(StringCalculator.add(nil)).to eq(0)
      end
    end

    context 'when input contains a single number' do
      it 'returns the number itself for positive numbers' do
        expect(StringCalculator.add('5')).to eq(5)
      end

      it 'returns the number itself for zero' do
        expect(StringCalculator.add('0')).to eq(0)
      end

      it 'returns the number itself for negative numbers' do
        expect(StringCalculator.add('-5')).to eq(-5)
      end
    end

    context 'when input contains multiple numbers with comma delimiters' do
      it 'returns the sum of two comma-separated numbers' do
        expect(StringCalculator.add('1,2')).to eq(3)
      end

      it 'returns the sum of many comma-separated numbers' do
        expect(StringCalculator.add('1,2,3,4')).to eq(10)
      end

      it 'handles large numbers correctly' do
        expect(StringCalculator.add('1000,2000,3000')).to eq(6000)
      end
    end

    context 'when input contains newline delimiters' do
      it 'handles newlines between numbers as delimiters' do
        expect(StringCalculator.add("1\n2,3")).to eq(6)
      end

      it 'handles only newline delimiters' do
        expect(StringCalculator.add("1\n2\n3")).to eq(6)
      end

      it 'handles mixed newline and comma delimiters' do
        expect(StringCalculator.add("1,2\n3,4\n5")).to eq(15)
      end
    end

    context 'when input contains custom delimiters' do
      it 'supports simple custom delimiter format //;<newline>numbers' do
        expect(StringCalculator.add("//;\n1;2")).to eq(3)
      end

      it 'supports custom delimiter with multiple numbers' do
        expect(StringCalculator.add("//;\n1;2;3;4")).to eq(10)
      end

      it 'supports custom delimiter with brackets format //[;]<newline>numbers' do
        expect(StringCalculator.add("//[;]\n1;2;3")).to eq(6)
      end

      it 'supports custom delimiter with special characters' do
        expect(StringCalculator.add("//*\n1*2*3")).to eq(6)
      end

      it 'supports custom delimiter with pipe character' do
        expect(StringCalculator.add("//|\n1|2|3")).to eq(6)
      end
    end

    context 'when input contains negative numbers' do
      it 'raises an error with single negative number' do
        expect { StringCalculator.add("1,-2,3") }
          .to raise_error(ArgumentError, "negative numbers not allowed -2")
      end

      it 'raises an error listing all negative numbers' do
        expect { StringCalculator.add("1,-2,3,-4") }
          .to raise_error(ArgumentError, "negative numbers not allowed -2,-4")
      end

      it 'raises an error with multiple negative numbers' do
        expect { StringCalculator.add("-1,-2,-3") }
          .to raise_error(ArgumentError, "negative numbers not allowed -1,-2,-3")
      end

      it 'raises an error with negative numbers in custom delimiter format' do
        expect { StringCalculator.add("//;\n1;-2;3") }
          .to raise_error(ArgumentError, "negative numbers not allowed -2")
      end
    end

    context 'edge cases and boundary conditions' do
      it 'handles input with only delimiters' do
        expect(StringCalculator.add(',,')).to eq(0)
      end

      it 'handles input with mixed delimiters and empty strings' do
        expect(StringCalculator.add("1,,2")).to eq(3)
      end

      it 'handles input with whitespace around numbers' do
        expect(StringCalculator.add(" 1 , 2 , 3 ")).to eq(6)
      end
    end
  end
end