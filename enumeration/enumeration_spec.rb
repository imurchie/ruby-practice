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
        @list.reduce{ |s,e| s + e}.should == 69
        @list.reduce(-10) { |s,e| s + e}.should == 59
        @list.reduce([]) { |s, e| s << e }.should == [3, 4, 7, 13, 42]
    end
    
    it "supports Enumerable#inject" do
        @list.inject(:+).should == 69
        @list.inject{ |s,e| s + e}.should == 69
        @list.inject(-10) { |s,e| s + e}.should == 59
        @list.inject([]) { |s, e| s << e }.should == [3, 4, 7, 13, 42]
    end
    
    it "supports Enumerable#min" do
      @list.min.should == 3
    end
    
    it "supports Enumerable#max" do
      @list.max.should == 42
    end
end