


module MyEnumerable
  def map
    if block_given?
      mapped_list = []
      each { |e| mapped_list << yield(e) }
      SortedList.new(mapped_list)
    else
      # generate an Enumerator
    end
  end
  
  def sort_by
    # make an array of arrays, such that in the sub array the first element is the yielded one, the other the original
    list = map { |e| [yield(e), e] }
    
    # sort the list, and map back to just the second element of each sub array
    # need to return a regular list, otherwise it will be re-sorted
    list.list.sort.map { |e| e[1] }
  end
  
  def select
    selected_list = []
    each do |e|
      selected_list << e if yield(e)
    end
    
    SortedList.new(selected_list)
  end
  
  def reduce(arg=nil)
    # we might get a symbol
    if arg.is_a?(Symbol)
      # expand into the canonical form
      return reduce { |t, e| t.send(arg, e) }
    end
    
    accumulator = arg
    each do |e|
      if accumulator
        accumulator = yield(accumulator, e)
      else
        # if we didn't have an argument, set the first element
        accumulator = e
      end
    end
    
    accumulator
  end
  
  def min
    min = nil
    each do |e|
      min = e unless min
      
      min = e if e < min
    end
    
    min
  end
  
  def max
    max = nil
    each do |e|
      max = e unless max
      
      max = e if e > max
    end
    
    max
  end
  
  alias :inject :reduce
end


class SortedList
  include MyEnumerable
  
  def initialize(list=[])
    @list = list.sort
  end
  
  def <<(element)
    @list << element
    @list.sort!
    
    # so we can chain
    self
  end
  
  def each
    if block_given?
      @list.each { |e| yield(e) }
    else
      # this should return an enumerator
    end
  end
  
  def ==(other)
    @list == other.list
  end
  
  def min
    # this is implemented in MyEnumerable, but SortedList makes it much more efficient
    @list[0]
  end
  
  def max
    # more efficient than MyEnumerable, since the internal list is sorted
    @list[-1]
  end
  
  protected
  def list
    # send out the list unprotected. Trust the calling class
    @list
  end
end