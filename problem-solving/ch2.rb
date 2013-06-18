#!/usr/bin/env ruby
# encoding: utf-8


# Chapter 2.


# print out a shape, using only two print operations:
# ########
#  ######
#   ####
#    ##
def problem0201
  0.upto(3) do |i|
    0.upto(7) do |j|
      print " " if i > j
      print "#" if j - i >= 0 && j + i <= 7
    end
    print "\n"
  end
end

# print out a shape:
#    ##
#   ####
#  ######
# ########
# ########
#  ######
#   ####
#    ##
def problem0202
  7.downto(0) do |i|
    n = i > 3 ? i % 4 : (3 - i).abs
    
    0.upto(7) do |j|
      print " " if n > j
      print "#" if j - n >= 0 && j + n <= 7
    end
    print "\n"
  end
end

# print a shape:
# #            #
#  ##        ##
#   ###    ###
#    ########
#    ########
#   ###    ###
#  ##        ##
# #            #
def problem0203
  0.upto(7) do |i|
    n = i < 4 ? i % 4 : 3 - (i % 4)
    
    0.upto(13) do |j|
      if (j >= n && j <= n+n) || (j >= 13-n-n && j <= 13-n)
        print "#"
      else
        print " "
      end
    end
    print "\n"
  end
end



puts "Problem 2.1"
problem0201

puts
puts "Problem 2.2"
problem0202

puts
puts "Problem 2.3"
problem0203