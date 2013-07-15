require "rspec"

require_relative "stack"


describe Stack do
  describe "new" do
    it "initializes empty stack" do
      stack = Stack.new
      stack.instance_variable_get(:@array).should == []
    end
    
    it "initializes with Array" do
      stack = Stack.new(["element", "element 2"])
      stack.instance_variable_get(:@array).should == ["element", "element 2"]
    end
    
    it "initializes with Hash" do
      stack = Stack.new("element" => true, "element 2" => true)
      stack.instance_variable_get(:@array).should == ["element", "element 2"]
    end
  end
  
  describe "push()" do
    it "pushes element to stack" do
      stack = Stack.new
      stack.push("element")
      stack.push("element 2")
      stack.instance_variable_get(:@array).should == ["element", "element 2"]
    end
  end
  
  describe "pop()" do
    it "supports popping last element" do
      stack = Stack.new
      stack.push("element")
      stack.pop.should == "element"
    end
    
    it "returns nil popping from initially empty stack" do
      stack = Stack.new
      stack.pop.should == nil
    end
    
    it "returns nil popping from empty stack" do
      stack = Stack.new
      stack.push("element")
      stack.pop
      stack.pop.should == nil
    end
  end
  
  describe "top()" do
    it "returns top element without changing it" do
      stack = Stack.new
      stack.push("element")
      stack.push("element 2")
      stack.top.should == "element 2"
      stack.instance_variable_get(:@array).should == ["element", "element 2"]
    end
    
    it "returns nil from initially empty stack" do
      stack = Stack.new
      stack.top.should == nil
    end
    
    it "returns nil from empty stack" do
      stack = Stack.new
      stack.push("element")
      stack.push("element 2")
      stack.pop
      stack.pop
      stack.top.should == nil
    end
  end
  
  describe "empty?" do
    it "returns true on initially empty stack" do
      stack = Stack.new
      stack.empty?.should == true
    end
    
    it "returns true on empty stack" do
      stack = Stack.new
      stack.push("element")
      stack.pop
      stack.empty?.should == true
    end
    
    it "returns false on non-empty stack" do
      stack = Stack.new
      stack.push("element")
      stack.empty?.should == false
    end
  end
  
  describe "length" do
    it "returns 0 for initially empty stack" do
      stack = Stack.new
      stack.length.should == 0
    end
    
    it "returns 0 for empty stack" do
      stack = Stack.new
      stack.push("element")
      stack.pop
      stack.length.should == 0
    end
    
    it "returns correct length for non-empty stack" do
      stack = Stack.new
      stack.push("element")
      stack.length.should == 1
      
      stack.push("element")
      stack.push("element")
      stack.length.should == 3
    end
  end
end