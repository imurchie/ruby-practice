require "rspec"

require_relative "enumeration"


describe MyEnumerable do
    before do
        @list = SortedList.new
        
        # will get stored internally as 3, 4, 7, 13, 42
        @list << 3 << 13 << 42 << 4 << 7
    end
    
    it "supports Enumerable#map" do
        @list.map{ |x| x+1}.should == SortedList.new([4,5,8,14,43])
    end
    
    it "supports Enumerable#sort_by" do
        # ascii sort order
        @list.sort_by{ |x| x.to_s}.should == [13,3,4,42,7]
    end
    
    it "supports Enumerable#select" do
        @list.select{ |x| x.even?}.should == SortedList.new([4,42])
    end
    
    it "supports Enumerable#reduce" do
        @list.reduce(:+).should == 69
        @list.reduce{ |s, e| s + e}.should == 69
        @list.reduce(-10) { |s, e| s + e}.should == 59
        @list.reduce([]) { |s, e| s << e }.should == [3, 4, 7, 13, 42]
    end
    
    it "supports Enumerable#inject" do
        @list.inject(:+).should == 69
        @list.inject{ |s, e| s + e}.should == 69
        @list.inject(-10) { |s, e| s + e}.should == 59
        @list.inject([]) { |s, e| s << e }.should == [3, 4, 7, 13, 42]
    end
    
    it "supports Enumerable#min" do
      @list.min.should == 3
    end
    
    it "supports Enumerable#max" do
      @list.max.should == 42
    end
    
    it "supports Enumerable#to_a" do
      @list.to_a.should == [3, 4, 7, 13, 42]
    end
    
    it "supports Enumerable#take" do
      @list.take(0).should == []
      @list.take(3).should == [3, 4, 7]
      @list.take(6).should == [3, 4, 7, 13, 42]
      lambda { @list.take(-1) }.should raise_error(ArgumentError)
    end
    
    it "supports Enumerable#take_while" do
      @list.take_while { |e| e < 10 }.should == [3, 4, 7]
    end
end

describe MyEnumerator do
    before do
        @list = SortedList.new
        
        @list << 3 << 13 << 42 << 4 << 7
    end
    
    it "supports next" do
        enum = @list.each
        enum.next.should == 3
        enum.next.should == 4
        enum.next.should == 7
        enum.next.should == 13
        enum.next.should == 42
        
        lambda { enum.next }.should raise_exception(StopIteration)
    end
    
    it "supports rewind" do
        enum = @list.each
        
        4.times { enum.next }
        enum.rewind
        
        2.times { enum.next }
        enum.next.should == 7
    end
    
    it "supports with_index" do
        enum = @list.map
        expected = ["0. 3", "1. 4", "2. 7", "3. 13", "4. 42"]
        
        enum.with_index { |e,i| "#{i}. #{e}" }.should == expected
    end
end