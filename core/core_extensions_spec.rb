require "rspec"

require_relative "core_extensions"

#describe Module do
#  describe "replacement attr_reader" do
#    before do
#      class Test
#        my_attr_reader :test, :test2
#        def initialize
#          @test   = 42
#          @test2  = 43
#        end
#      end
#      @d = Test.new
#      
#      @c = Class.new do
#        my_attr_reader :test, :test2
#        def initialize
#          @test = 42
#        end
#      end
#    end
#    
#    it "adds getter to class created with Class.new" do
#      #@c.test.should == 42
#    end
#    
#    it "adds getter to class created with class keyword" do
#      #@d.test.should == 42
#    end
#  end
#end

describe Array do
  describe "initialize with offset" do
    # Array has three initialize methods
    it "initializes with size and an object" do
      a = Array.new(10, "hi", 2)
      
      a[2].should == "hi"
      a.offset.should == 2
    end
  end
end