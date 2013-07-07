#!/usr/bin/env ruby
# encoding: utf-8


# Playing with sorting algorithms


# The algorithm starts at the beginning of the data set. It compares the first two elements, and if the first is greater than the second, it swaps them. It continues doing this for each pair of adjacent elements to the end of the data set. It then starts again with the first two elements, repeating until no swaps have occurred on the last pass.
# average O(n^2)
def bubble_sort(a)
  array = a.clone
  
  final = false
  while !final
    final = true
    1.upto(array.length-1) do |index|
      if array[index] < array[index-1]
        array[index], array[index-1] = array[index-1], array[index]
        final = false
      end
    end
  end
  
  array
end

# The algorithm finds the minimum value, swaps it with the value in the first position, and repeats these steps for the remainder of the list. It does no more than n swaps, and thus is useful where swapping is very expensive.
# O(n^2)
def selection_sort(a)
  array = a.clone
  
  insert = 0
  array.each_index do |i|
    min = i
    (i+1).upto(array.length-1) do |j|
      if array[j] < array[min]
        min = j
      end
    end
    array[i], array[min] = array[min], array[i]
  end
  
  array
end

# Insertion sort is a simple sorting algorithm that is relatively efficient for small lists and mostly sorted lists, and often is used as part of more sophisticated algorithms. It works by taking elements from the list one by one and inserting them in their correct position into a new sorted list. In arrays, the new list and the remaining elements can share the array's space, but insertion is expensive, requiring shifting all following elements over by one.
# O(n^2)
def insertion_sort(a)
  array = a
  
  1.upto(array.length-1) do |i|
    if array[i] < array[i-1]
      # need to shift everything over until it isn't
      i.downto(1) do |j|
        if array[j] < array[j-1]
          array[j], array[j-1] = array[j-1], array[j]
        end
      end
    end
  end
  
  array
end


# Shellsort, also known as Shell sort or Shell's method, is an in-place comparison sort. It generalizes an exchanging sort, such as insertion or bubble sort, by starting the comparison and exchange of elements with elements that are far apart before finishing with neighboring elements. Starting with far apart elements can move some out-of-place elements into position faster than a simple nearest neighbor exchange. Donald Shell published the first version of this sort in 1959.[1][2] The running time of Shellsort is heavily dependent on the gap sequence it uses. For many practical variants, determining their time complexity remains an open problem.
# using Shell's original gap sequence: floor(n/(2^k)) [O(n^2)]
def shell_sort(a)
  array = a
  
  m = 1
  while (gap = array.length / (2 ** m)) >= 1
    puts "gap: #{gap}"
    0.step(array.length-1, gap) do |i|
      #puts "#{i}"
      # insertion sort
      #puts "    ###{i+gap}"
      (i+1).upto(i+gap-1) do |j|
        #puts "    #{j}"
        if array[j] < array[j-1]
          # need to shift everything over until it isn't
          j.downto(i+1) do |k|
            if array[k] < array[k-1]
              array[k], array[k-1] = array[k-1], array[k]
            end
          end
        end
      end
      p a
    end
    
    m += 1
  end
end


# O(nlogn)
def merge_sort(a)
  array = a
  
  # base case: an empty array, or one with 1 element, is sorted already
  return a if a.length <= 1
  
  first = merge_sort(a[0..a.length/2-1])
  second = merge_sort(a[a.length/2..a.length-1])
  
  # merge
  res = []
  i = j = 0
  while i < first.length || j < second.length
    if i == first.length
      res << second[j]
      j += 1
    elsif j == second.length
      res << first[i]
      i += 1
    elsif first[i] < second[j]
      res << first[i]
      i += 1
    else
      res << second[j]
      j += 1
    end
  end
  
  res
end


# O(nlogn) - but requires much (i.e. O(n)) extra space (and is therefore no better than merge sort).
def quick_sort(a)
  array = a
  
  # already sorted!
  return array if array.length <= 1
  
  pivot = array.length / 2
  
  lower = []
  higher = []
  array.length.times do |i|
    next if i == pivot
    
    if array[i] >= array[pivot]
      higher << array[i]
    else
      lower << array[i]
    end
  end
  
  return quick_sort(lower) + [array[pivot]] + quick_sort(higher)
end

#a = [5, 9, 3, 8, 5, 7, 4, 23, 42, 22, 59, 76, 54, 55, 31, 33]
#a = [5,4,1,8,7,2,6,3,9]
#puts "array: #{a.inspect}"
#p quick_sort(a)