require "rspec"

require_relative "sort"




describe "Sorting Methods" do
  before do
    @array = []
    10000.times { @array << rand(10000) }
    
    @sorted_array = @array.sort
  end
  
  it "bubble sort" do
    bubble_sort(@array).should == @sorted_array
  end
  
  it "selection sort" do
    selection_sort(@array).should == @sorted_array
  end
  
  it "insertion sort" do
    insertion_sort(@array).should == @sorted_array
  end
  
  it "merge sort" do
    merge_sort(@array).should == @sorted_array
  end
  
  it "quick sort" do
    quick_sort(@array).should == @sorted_array
  end
end