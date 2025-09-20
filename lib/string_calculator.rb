class StringCalculator
  def self.add(input)
    return 0 if input.nil? || input == ''
    return input.to_i if input.match?(/\A-?\d+\z/)

    tokens = input.split(',')
    numbers = tokens.map(&:to_i)
    numbers.sum
  end
end