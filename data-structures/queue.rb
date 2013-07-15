class Queue
  def initialize(array = [])
    @array = []
    array.each { |e| @array << e.clone }
  end
  
  def enqueue(element)
    @array << element
    self
  end
  
  def dequeue
    @array.shift
  end
  
  def empty?
    @array.empty?
  end
  
  def length
    @array.length
  end
end


# This is unnecessary. Ruby Arrays are pretty efficient at dequeue operations, where we would expect some bottleneck (see ).
# This class could be refactored to be more efficient, I'm sure.
class ListQueue
  def initialize(array = [])
    @start  = nil
    @end    = nil
    @count  = 0
    
    array.each { |e| enqueue(e) }
  end
  
  def enqueue(element)
    node = Node.new(nil, element)
    if @start.nil?
      @start = node
    end
    if @end.nil?
      @end = node
    else
      @end.next_node = node
      @end = node
    end
    
    @count += 1
    
    self
  end
  
  def dequeue
    node = @start
    return nil unless node
    
    @start = node.next_node
    node.next_node = nil
    
    @count -= 1
    
    node.element
  end
  
  def empty?
    length == 0
  end
  
  def length
    return @count
  end
  
  class Node
    attr_reader :next_node, :element
    attr_writer :next_node
    
    def initialize(next_node, element)
      @next_node  = next_node
      @element    = element
    end
  end
end

require "benchmark"

Benchmark.bm do |bm|
  count = 1000000
  
  arr_queue = Queue.new
  bm.report("Array adding: ") do
    count.times { arr_queue.enqueue(rand(1000)) }
  end
  bm.report("Array remove: ") do
    count.times { arr_queue.dequeue }
  end
  
  list_queue = ListQueue.new
  bm.report("List adding:  ") do
    count.times { list_queue.enqueue(rand(1000)) }
  end
  bm.report("List remove:  ") do
    count.times { list_queue.dequeue }
  end
end

#        user     system      total        real
# Array adding:   0.250000   0.010000   0.260000 (  0.251864)
# Array remove:   0.130000   0.000000   0.130000 (  0.125537)
# List adding:    0.650000   0.020000   0.670000 (  0.680395)
# List remove:    0.220000   0.000000   0.220000 (  0.219705)