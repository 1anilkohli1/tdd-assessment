class StringCalculator
  def self.add(input)
    return 0 if input.nil? || input == ''
    # If input is a single number
    return input.to_i if input.match?(/\A-?\d+\z/)

    numbers_string = input.dup
    delimiters = [',', "\n"]

    if numbers_string.start_with?('//')
      header, numbers_string = numbers_string.split("\n", 2)
      custom = header[2..] # after //
      # support simple [delim] or plain delim
      if custom.start_with?('[') && custom.end_with?(']')
        custom = custom[1..-2]
      end
      delimiters << custom
    end

    # build split pattern and split tokens
    pattern = Regexp.union(*delimiters)
    tokens = numbers_string.split(pattern)
    integers = tokens.map { |t| t.to_i }

    negatives = integers.select { |n| n < 0 }
    if negatives.any?
      raise ArgumentError, "negative numbers not allowed #{negatives.join(',')}"
    end

    integers.sum
  end
end