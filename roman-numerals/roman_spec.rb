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
  
  it "support lowercase new-style Roman numerals" do
    Numeral.new(1, true).new_roman.should     == "i"
    Numeral.new(8, true).new_roman.should     == "viii"
    Numeral.new(9, true).new_roman.should     == "ix"
    Numeral.new(501, true).new_roman.should   == "di"
    Numeral.new(707, true).new_roman.should   == "dccvii"
    Numeral.new(890, true).new_roman.should   == "dcccxc"
    Numeral.new(900, true).new_roman.should   == "cm"
    Numeral.new(1500, true).new_roman.should  == "md"
    Numeral.new(1900, true).new_roman.should  == "mcm"
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
  
  it "support lowercase old-style Roman numerals" do
    Numeral.new(1, true).old_roman.should     == "i"
    Numeral.new(8, true).old_roman.should     == "viii"
    Numeral.new(9, true).old_roman.should     == "viiii"
    Numeral.new(501, true).old_roman.should   == "di"
    Numeral.new(707, true).old_roman.should   == "dccvii"
    Numeral.new(890, true).old_roman.should   == "dccclxxxx"
    Numeral.new(900, true).old_roman.should   == "dcccc"
    Numeral.new(1500, true).old_roman.should  == "md"
    Numeral.new(1900, true).old_roman.should  == "mdcccc"
  end
end