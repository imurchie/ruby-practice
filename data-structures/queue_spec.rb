require "rspec"

require_relative "queue"


describe Queue do
  describe "new" do
    it "initializes an empty queue" do
      queue = Queue.new
      queue.length.should == 0
    end
    
    it "initializes a queue from an Array" do
      queue = Queue.new(["element", "element 2"])
      queue.length.should == 2
    end
  end
  
  describe "enqueue(e)" do
    it "adds to the end of the queue" do
      queue = Queue.new
      queue.enqueue("element")
      queue.enqueue("element 2")
      
      queue.length.should == 2
      queue.dequeue.should == "element"
    end
  end
  
  describe "dequeue()" do
    it "removes an element from the head of the queue" do
      queue = Queue.new(["element", "element 2"])
      queue.dequeue.should == "element"
    end
    
    it "returns nil from empty queue" do
      queue = Queue.new
      queue.dequeue.should == nil
    end
  end
  
  describe "empty?" do
    it "returns true for empty queue" do
      queue = Queue.new
      queue.empty?.should == true
    end
    
    it "returns false for non-empty queue" do
      queue = Queue.new(["element", "element 2"])
      queue.empty?.should == false
    end
  end
  
  describe "length" do
    it "returns 0 for empty queue" do
      queue = Queue.new
      queue.length.should == 0
    end
    
    it "returns correct length for non-empty queue" do
      queue = Queue.new(["element", "element 2"])
      queue.length.should == 2
      
      queue.enqueue("element 3")
      queue.length.should == 3
      
      queue.dequeue
      queue.length.should == 2
    end
  end
end