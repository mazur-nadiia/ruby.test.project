require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

class MainClasses <Test::Unit::TestCase
  def sumOfNumbers(number)
    result = 0;
    number.to_s.each_char do |i|
        result +=i.to_i;
    end
    result;
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
    result;
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
    number_array.sort.last();
  end

  def test_findMaximumNumberInString
    assert_equal(1119, findMaximumNumberInString("fer32qw1119gt4"));
    assert_equal(19, findMaximumNumberInString("fer2qw19gt4"));
    assert_equal(nil, findMaximumNumberInString("abcd"));
  end

  def findFirstMatchingChar(string1, string2)
    string1.each_char do |char|
      if (string2.include? char)
        return char;
      end
    end
    '';
  end

  def test_findFirstMatchingChar
    assert_equal('e',findFirstMatchingChar("fraefe", "svedd"))
    assert_equal('t',findFirstMatchingChar("gjt35ie", "fq 3q4r wed tae"))
    assert_equal('',findFirstMatchingChar("frfafweaefe", "12345678 5678"))
  end

  def puts_even_odd(array)
    even  = []
    array.each_with_index {|val, index|
      if (index % 2 == 0)
        puts val;
      else
        even << val;
      end;
    }
    puts even;
  end
  def test_even_odd
    puts_even_odd(["0", "1","2","3","4", "5", "6", "7", "8"])
  end
  def array_conditions(ary)
    result = 0;
    ary.each_with_index do |elem, index|
      if (elem > ary[0]) & (elem < ary[-1])
        result = index;
      end
    end
    result
  end
  def test_array_conditions
    assert_equal(10,array_conditions([-45,2,7,9,32,5,2,9,9,3,1,6,3]))
    assert_equal(7,array_conditions([-45,2,7,9,32,5,2,2,5,6,5,6,3]))
  end

  def array_increment(ary)
    ary.each_with_index { |val, index|
      if (index % 2 == 0) & (index !=0) & (index != ary.size() -1)
        ary[index]=ary[index]+ary[0]
      end;
    }
    ary
  end
  def test_array_increment
    assert_equal([5,2,11,2,12,4,7],array_increment([5,2,6,2,7,4,7]))
  end

end