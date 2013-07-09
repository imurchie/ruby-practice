# playing around with Tom Stuart's "Understanding Computation"

module Simple
  module SimpleBase
    def inspect
      "<<#{self}>>"
    end
  end
  
  class Number
    include Simple::SimpleBase
    
    attr_accessor :value
    
    def initialize(value)
      @value = value
    end
    
    def to_s
      value.to_s
    end
    
    def reducible?
      false
    end
    
    def reduce
      # not reducible. Just return a new object with the same value
      Number.new(value)
    end
  end
  
  class Add
    include SimpleBase
    
    attr_accessor :left,  :right
    
    def initialize(left, right)
      @left = left
      @right = right
    end
    
    def to_s
      "#{left} + #{right}"
    end
    
    def reducible?
      true
    end
    
    def reduce
      if left.reducible?
        Add.new(left.reduce, right)
      elsif right.reducible?
        Add.new(left, right.reduce)
      else
        Number.new(left.value + right.value)
      end
    end
  end
  
  class Multiply
    include SimpleBase
    
    attr_accessor :left,  :right
    
    def initialize(left, right)
      @left = left
      @right = right
    end
    
    def to_s
      "#{left} * #{right}"
    end
    
    def reducible?
      true
    end
    
    def reduce
      if left.reducible?
        Multiply.new(left.reduce, right)
      elsif right.reducible?
        Multiply.new(left, right.reduce)
      else
        Number.new(left.value * right.value)
      end
    end
  end
end

operation = Simple::Add.new(
  Simple::Multiply.new(Simple::Number.new(1), Simple::Number.new(2)),
  Simple::Multiply.new(Simple::Number.new(3), Simple::Number.new(4))
)

puts operation

puts "Performing the operation..."
while operation.reducible?
  operation = operation.reduce
  puts operation
end