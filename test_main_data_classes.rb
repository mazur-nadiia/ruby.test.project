require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

class MainClasses <Test::Unit::TestCase
  def sumOfNumbers(number)
    result = 0;
    number.to_s.each_char do |i|
        result +=i.to_i;
    end
    return result;
  end

  def test_sum
    assert_equal(15, sumOfNumbers(12345));
    assert_equal(4, sumOfNumbers(1111));
    assert_equal(5, sumOfNumbers(302));
  end

  def findMaximumNumberOfDigits(string)
    current_count=0;
    result=0;
    string.each_char do |char|
      if (('0'..'9').include? char)
        current_count=current_count+1;
      else
        if (result<current_count)
          result=current_count;
        end;
        current_count=0;
      end
    end
    return result;
  end

  def test_findMaximumNumberOfDigits()
    assert_equal(4, findMaximumNumberOfDigits("fer32qw1119gt4"));
    assert_equal(2, findMaximumNumberOfDigits("fer2qw19gt4"));
    assert_equal(0, findMaximumNumberOfDigits("abcd"));
  end

  def findMaximumNumberInString(string)
    current_number_string="";
    number_array=[];
    string.each_char do |char|
      if (('0'..'9').include? char)
        current_number_string=current_number_string + char;
      else
        if (current_number_string != "")
           number_array << current_number_string.to_i;
        end
        current_number_string="";
      end
    end
    return number_array.sort.last();
  end

  def test_findMaximumNumberInString
    assert_equal(1119, findMaximumNumberInString("fer32qw1119gt4"));
    assert_equal(19, findMaximumNumberInString("fer2qw19gt4"));
    assert_equal(nil, findMaximumNumberInString("abcd"));
  end

end