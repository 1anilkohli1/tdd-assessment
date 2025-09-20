# StringCalculator - A TDD implementation following the Incubyte assessment requirements
#
# This class provides functionality to add numbers from a string input
# with support for various delimiters and error handling for negative numbers.
#
# @example Basic usage
#   StringCalculator.add("1,2,3") # => 6
#   StringCalculator.add("1\n2,3") # => 6
#   StringCalculator.add("//;\n1;2;3") # => 6
#
# @example Error handling
#   StringCalculator.add("1,-2,3") # => raises ArgumentError
class StringCalculator
  # Default delimiters supported by the calculator
  DEFAULT_DELIMITERS = [',', "\n"].freeze
  
  # Custom delimiter pattern for parsing delimiter definitions
  CUSTOM_DELIMITER_PATTERN = /\A\/\/(.+)\n(.+)\z/m
  
  # Adds numbers from a string input with support for various delimiters
  #
  # @param input [String] The input string containing numbers separated by delimiters
  # @return [Integer] The sum of all numbers in the input
  # @raise [ArgumentError] When negative numbers are present in the input
  #
  # @example Empty string
  #   add("") # => 0
  #
  # @example Single number
  #   add("5") # => 5
  #
  # @example Comma-separated numbers
  #   add("1,2,3") # => 6
  #
  # @example Newline delimiters
  #   add("1\n2,3") # => 6
  #
  # @example Custom delimiter
  #   add("//;\n1;2;3") # => 6
  #
  # @example With negative numbers (raises error)
  #   add("1,-2,3") # => raises ArgumentError: "negative numbers not allowed -2"
  def self.add(input)
    return 0 if empty_input?(input)
    return parse_single_number(input) if single_number?(input)

    numbers_string, delimiters = parse_delimiters(input)
    numbers = extract_numbers(numbers_string, delimiters)
    
    validate_no_negatives(numbers)
    numbers.sum
  end

  private

  # Checks if the input is empty or nil
  #
  # @param input [String] The input to check
  # @return [Boolean] True if input is empty or nil
  def self.empty_input?(input)
    input.nil? || input.empty?
  end

  # Checks if the input contains only a single number
  #
  # @param input [String] The input to check
  # @return [Boolean] True if input is a single number
  def self.single_number?(input)
    input.match?(/\A-?\d+\z/)
  end

  # Parses a single number from input
  #
  # @param input [String] The single number string
  # @return [Integer] The parsed number
  def self.parse_single_number(input)
    input.to_i
  end

  # Parses delimiters from the input string, including custom delimiters
  #
  # @param input [String] The input string
  # @return [Array] Array containing [numbers_string, delimiters_array]
  def self.parse_delimiters(input)
    numbers_string = input.dup
    delimiters = DEFAULT_DELIMITERS.dup

    if custom_delimiter_present?(numbers_string)
      numbers_string, custom_delimiter = extract_custom_delimiter(numbers_string)
      delimiters << custom_delimiter
    end

    [numbers_string, delimiters]
  end

  # Checks if a custom delimiter is present in the input
  #
  # @param input [String] The input string
  # @return [Boolean] True if custom delimiter is present
  def self.custom_delimiter_present?(input)
    input.start_with?('//')
  end

  # Extracts custom delimiter from the input string
  #
  # @param input [String] The input string with custom delimiter
  # @return [Array] Array containing [numbers_string, delimiter]
  def self.extract_custom_delimiter(input)
    header, numbers_string = input.split("\n", 2)
    custom_delimiter = header[2..] # Remove '//' prefix
    
    # Support both [delimiter] and plain delimiter formats
    if custom_delimiter.start_with?('[') && custom_delimiter.end_with?(']')
      custom_delimiter = custom_delimiter[1..-2] # Remove brackets
    end
    
    [numbers_string, custom_delimiter]
  end

  # Extracts numbers from a string using the provided delimiters
  #
  # @param numbers_string [String] The string containing numbers
  # @param delimiters [Array] Array of delimiter strings
  # @return [Array<Integer>] Array of parsed integers
  def self.extract_numbers(numbers_string, delimiters)
    pattern = Regexp.union(*delimiters)
    tokens = numbers_string.split(pattern)
    tokens.map(&:to_i)
  end

  # Validates that no negative numbers are present
  #
  # @param numbers [Array<Integer>] Array of numbers to validate
  # @raise [ArgumentError] When negative numbers are found
  def self.validate_no_negatives(numbers)
    negative_numbers = numbers.select(&:negative?)
    
    if negative_numbers.any?
      error_message = "negative numbers not allowed #{negative_numbers.join(',')}"
      raise ArgumentError, error_message
    end
  end
end