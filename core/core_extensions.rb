# some tests of facilities to extend core elements of the Ruby library

class Module
  def my_attr_reader(*args)
    args.each do |attr|
      # we need to create with self and self.class
      # because if we create with class we use self
      # if Class.new we use self.class (WHY?)
      [self, self.class].each do |receiver|
        receiver.send(:define_method, attr) do
          instance_variable_get("@#{attr}")
        end
      end
    end
  end
end



class Array
  # add functionality to allow for subscripting of different ranges (i.e., not zero-based)
  #alias_method  :init, :initialize  # save the old one
  alias_method  :init, :initialize
  
  attr_accessor :offset
  
  def initialize(*args, &block)
    case args.length
    when 0
      init
    when 1
      init(args[0])
    when 2
      # here args[0] can be an integer, which is the size
      # or an Array, which is the 
    end
    @offset = offset
  end
  
  #def initialize(array, offset=0)
  #  super(array)
  #  
  #  @offset = offset
  #end
  
  #def initialize(size=0, offset=0, &block)
  #  super(size, nil, &block)
  #  
  #  @offset = offset
  #end
end


a = Array.new(3, "hi", 4)
p a

puts
b = Array.new(3, 2) { |i| i ** 2 }
p b

puts
c = Array.new([2, 3, 4], 4)