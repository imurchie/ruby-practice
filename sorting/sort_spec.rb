require "rspec"

require_relative "sort"




describe "Sorting Methods" do
  before do
    @array = []
    1000.times { @array << rand(1000) }
    
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
end