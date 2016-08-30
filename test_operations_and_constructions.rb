require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

class OperationsConstructions <Test::Unit::TestCase
  def generateRandomNumbers(stringCount)
    result = []
    begin
      result << rand(9)
      stringCount=stringCount-1
    end while stringCount > 0
    result
  end

  def test_generateRandomNumbers()
    randomNumbers = generateRandomNumbers(10)
    randomNumbers.each_with_index do |elem, index|
      puts elem
      is_even = ->(x) { x % 2 == 0 }
      case elem
        when 0 then puts "we've got 0"
        when is_even then puts "the number is even"
        else puts "the number is odd"
      end;
      case elem
        when 0..4 then puts "the number is less than 5"
        when 5 then puts "the number is equal to 5"
        when 6..9 then puts "the number is more than 5"
      end
      puts "========="
    end

  end

end
