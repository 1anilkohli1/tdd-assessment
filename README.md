# String Calculator - TDD Implementation

A Test-Driven Development (TDD) implementation of the String Calculator kata for the Incubyte Software Craftsperson assessment.

## Overview

This project demonstrates professional software craftsmanship through a complete TDD implementation of a string calculator that can handle various number formats and delimiters. The implementation follows the [Incubyte TDD Assessment](https://blog.incubyte.co/blog/tdd-assessment/) requirements.

## Features

**All 5 Assessment Requirements Implemented:**

1. **Basic Addition**: Handles empty strings, single numbers, and comma-separated numbers
2. **Multiple Numbers**: Supports any amount of numbers in the input
3. **Newline Delimiters**: Handles newlines between numbers (`"1\n2,3"` returns `6`)
4. **Custom Delimiters**: Supports custom delimiters with `//[delimiter]\n[numbers...]` format
5. **Negative Number Validation**: Throws descriptive exceptions for negative numbers

## Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd tdd-assessment
```

2. Install dependencies:
```bash
bundle install
```

## Project Structure

```
tdd-assessment/
├── lib/
│   └── string_calculator.rb      # Main implementation
├── spec/
│   ├── spec_helper.rb            # RSpec configuration
│   └── string_calculator_spec.rb # Test suite
├── Gemfile                       # Ruby dependencies
├── Gemfile.lock                  # Locked dependency versions
├── .rspec                        # RSpec configuration
├── .gitignore                    # Git ignore rules
└── README.md                     # This file
```

## Usage

### Basic Examples

```ruby
require_relative 'lib/string_calculator'

# Empty string returns 0
StringCalculator.add("") # => 0

# Single number
StringCalculator.add("5") # => 5

# Comma-separated numbers
StringCalculator.add("1,2,3") # => 6

# Newline delimiters
StringCalculator.add("1\n2,3") # => 6

# Custom delimiters
StringCalculator.add("//;\n1;2;3") # => 6
StringCalculator.add("//*\n1*2*3") # => 6

# Error handling for negative numbers
StringCalculator.add("1,-2,3") # => raises ArgumentError: "negative numbers not allowed -2"
```

### Advanced Examples

```ruby
# Mixed delimiters
StringCalculator.add("1,2\n3,4\n5") # => 15

# Custom delimiter with brackets
StringCalculator.add("//[;]\n1;2;3") # => 6

# Large numbers
StringCalculator.add("1000,2000,3000") # => 6000

# Multiple negative numbers
StringCalculator.add("1,-2,3,-4") # => raises ArgumentError: "negative numbers not allowed -2,-4"
```

## Running Tests

Run the complete test suite:
```bash
bundle exec rspec
```

Run with detailed output:
```bash
bundle exec rspec --format documentation
```

## TDD Implementation History

This project demonstrates a complete TDD cycle with the following commit progression:

1. **Empty String Support** - Red → Green → Refactor
2. **Single Number Support** - Red → Green → Refactor  
3. **Comma-Separated Numbers** - Red → Green → Refactor
4. **Newline Delimiters** - Red → Green → Refactor
5. **Custom Delimiters** - Red → Green → Refactor
6. **Negative Number Validation** - Red → Green → Refactor

Each commit shows the evolution of the code following the Red-Green-Refactor cycle.

## Code Quality Features

- **Comprehensive Documentation**: Full YARD documentation with examples
- **Clean Architecture**: Well-structured methods with single responsibilities
- **Edge Case Handling**: Robust handling of various input scenarios
- **Professional Error Messages**: Clear, descriptive error messages
- **Extensive Test Coverage**: 23 test cases covering all scenarios and edge cases

## Technical Stack

- **Ruby**: Modern Ruby with clean, readable syntax
- **RSpec**: Comprehensive testing framework
- **Bundler**: Dependency management
- **Git**: Version control with meaningful commit messages


## Author

**Anil** - Software Craftsperson Candidate  
*Incubyte TDD Assessment Submission*
