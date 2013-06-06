require "rspec"

require_relative "roman"


describe Numeral do
  it "supports integer retrieval" do
    n = Numeral.new(4)
    n.integer.should == 4
  end
  
  it "support new-style Roman numerals" do
    Numeral.new(1).new_roman.should     == "I"
    Numeral.new(8).new_roman.should     == "VIII"
    Numeral.new(9).new_roman.should     == "IX"
    Numeral.new(501).new_roman.should   == "DI"
    Numeral.new(707).new_roman.should   == "DCCVII"
    Numeral.new(890).new_roman.should   == "DCCCXC"
    Numeral.new(900).new_roman.should   == "CM"
    Numeral.new(1500).new_roman.should  == "MD"
    Numeral.new(1900).new_roman.should  == "MCM"
  end
  
  it "support old-style Roman numerals" do
    Numeral.new(1).old_roman.should     == "I"
    Numeral.new(8).old_roman.should     == "VIII"
    Numeral.new(9).old_roman.should     == "VIIII"
    Numeral.new(501).old_roman.should   == "DI"
    Numeral.new(707).old_roman.should   == "DCCVII"
    Numeral.new(890).old_roman.should   == "DCCCLXXXX"
    Numeral.new(900).old_roman.should   == "DCCCC"
    Numeral.new(1500).old_roman.should  == "MD"
    Numeral.new(1900).old_roman.should  == "MDCCCC"
  end
end