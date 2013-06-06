# Pine. p. 68. Convert integer into Roman numerals


class Numeral
  def initialize(num)
    @num = num
    @num.freeze
  end
  
  def integer
    @num
  end
  
  
  # 9 = VIIII
  def old_roman
    num = @num  # need temp variable in order to increment
    
    numeral = ""
    
    mods      = [5, 10, 50, 100, 500, 1000, 10000]
    steps     = [-1, -5, -10, -50, -100, -500, -1000]
    numerals  = ["I", "V", "X", "L", "C", "D", "M"]
    
    0.upto(6) do |i|
      break if num <= 0
        
      (num % mods[i]).step(1, steps[i]) do
        numeral = numerals[i] + numeral
        num += steps[i]
      end
    end
    
    numeral
  end

  # 9 = IX
  def new_roman
    num = @num  # need temp variable in order to increment
    
    numeral = ""
    
    mods      = [5, 10, 50, 100, 500, 1000, 10000, 100000]
    steps     = [-1, -5, -10, -50, -100, -500, -1000, -10000]
    numerals  = ["I", "V", "X", "L", "C", "D", "M", "NEVER GET HERE"]
    
    if num % 10 == 9
      numeral = "IX" + numeral
      num -= 9
    elsif num % 5 == 4
      numeral = "IV" + numeral
      num -= 4
    else
      (num % 5).step(1, -1) { |i| numeral = "I" + numeral; num -= 1 }
    end
    
    if num % 100 == 90
      numeral = "XC" + numeral
      num -= 90
    elsif num % 50 == 40
      numeral = "XL" + numeral
      num -= 40
    else
      (num % 10).step(1, -5) { numeral = "V" + numeral; num -= 5 }
    end
    
    if num % 1000 == 900
      numeral = "CM" + numeral
      num -= 900
    elsif num % 500 == 400
      numeral = "CD" + numeral
      num -= 400
    else
      (num % 50).step(1, -10) { numeral = "X" + numeral; num -= 10 }
    end
    
    (num % 100).step(1, -50) { numeral = "L" + numeral; num -= 50 }
    
    (num % 500).step(1, -100) { numeral = "C" + numeral; num -= 100 }
    
    (num % 1000).step(1, -500) { numeral = "D" + numeral; num -= 500 }
    
    (num % 10000).step(1, -1000) { numeral = "M" + numeral; num -= 1000 }
    
    numeral
  end
end