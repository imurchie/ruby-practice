require "rspec"

require_relative "openstruct"


describe Practice::MyOpenStruct do
  it "supports OpenStruct#new(Hash)" do
    attributes = {test: "this is a test"}
    s = Practice::MyOpenStruct.new(attributes)
    
    s.test.should == "this is a test"
  end
  
  describe "supports OpenStruct#==(other)" do
    before do
      attributes = {test: "this is a test"}
      @s1 = Practice::MyOpenStruct.new(attributes)
      @s2 = Practice::MyOpenStruct.new(attributes)
      
      attributes[:test2] = "this is another test"
      @s3 = Practice::MyOpenStruct.new(attributes)
    end
    
    it "with identical structures" do
      @s1.should == @s2
    end
    
    it "with different structures" do
      @s1.should_not == @s3
    end
  end
  
  describe "setting attributes" do
    before do
      @s = Practice::MyOpenStruct.new
    end
    
    it "of String types" do
      @s.string = "This is a string"
      
      @s.string.should == "This is a string"
    end
    
    it "of Array types" do
      @s.array = [1, 3, 24, 5]
      
      @s.array.should == [1, 3, 24, 5]
    end
  
    it "of ad hoc types" do
      test_class = Class.new {}
      @s.klass = test_class
      
      @s.klass.should == test_class
    end
  end
  
  describe "supports OpenStruct#delete_field(name)" do
    it "with String param" do
      s = Practice::MyOpenStruct.new
      s.test = "this is a test"
    
      s.test.should == "this is a test"
      s.delete_field("test").should == "this is a test"
      s.test.should == nil
    end
    
    it "with Symbol param" do
      s = Practice::MyOpenStruct.new
      s.test = "this is a test"
      
      s.test.should == "this is a test"
      s.delete_field(:test).should == "this is a test"
      s.test.should == nil
    end
  
    it "raises NameError when param not found" do
      s = Practice::MyOpenStruct.new
      
      s.test.should == nil
      lambda { s.delete_field("test") }.should raise_error(NameError)
    end
  end
end