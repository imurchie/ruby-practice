require "rspec"

require_relative "openstruct"


describe Practice::MyOpenStruct do
  xit "supports OpenStruct#new" do
  end
  
  xit "supports OpenStruct#new(Hash)" do
  end
  
  xit "supports OpenStruct#==(other)" do
  end
  
  describe "setting attributes" do
    before do
      @s = Practice::MyOpenStruct.new
    end
    
    it "of String types" do
      @s.string = "This is a string"
      
      @s.string.should == "This is a string"
    end
    
    xit "of Array types" do
    end
  
    xit "of Fixnum types" do
    end
  
    xit "of ad hoc types" do
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
  
  xit "supports OpenStruct#initialize_copy(orig)" do
  end
end