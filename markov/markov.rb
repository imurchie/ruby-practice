#!/usr/bin/env ruby
# encoding: utf-8


module Practice
  class MarkovChain
    def initialize(corpus, key_length = 1)
      @corpus     = corpus
      @key_length = key_length
    
      @elements = []
    
      parse_chains
    end
  
    def text(length = 140)
      str = ""
      element = nil
      while str.length < length do
        unless element
          element = get_start_element
          str = element.words.join(" ")
        end
      
        next_word = element.next
      
        break if str.length + next_word.length > length
      
        str << " #{next_word}"
      
        if str[-1] =~ /[\.?!]/
          break
          #element = get_start_element
        else
          words = element.words.flatten
          words.shift
          words << next_word
      
          element = find_element(words)
        end
      end
    
      str.capitalize
    end
  
    def +(corpus)
      raise ArgumentError.new("Can only understand strings") unless corpus.kind_of?(String)
    
      @corpus = @corpus ? @corpus + corpus : corpus
    
      parse_chains
    end
  
    private
    def parse_chains
      words = @corpus.split(" ")
    
      i = 0
      while i < words.length - @key_length + 1
        j = i # internal counter, otherwise @key_length > 1 fails
      
        n_gram = []
        @key_length.times do
          n_gram << words[j]
          j += 1
        end
      
        element = find_element(n_gram)
        unless element
          # no element found... add new one
          element = Element.new(n_gram)
          @elements << element
        end
      
        successor = words[j]
        element.add_successor(successor)
      
        # move on to the next word
        i += 1
      end
    end
  
    private
    def find_element(words)
      @elements.each do |element|
        return element if words == element.words
      end
    
      nil
    end
  
    private
    def get_start_element
      while true
        element = @elements[rand(@elements.length)]
        return element if element.words[0][0] =~ /[A-Z]/
      end
    end
  
    protected
    class Element
      def initialize(words)
        @words = words
      
        @map = Hash.new(0)
      end
    
      def words
        @words
      end
    
      def first_word
        @words[0]
      end
    
      def add_successor(succ)
        @map[succ] += 1
      end
    
      def next
        return nil if @map.empty?
      
        # make histogram by reversing key and value
        hist = @map.inject([]) do |arr, h|
          arr << [h[1], h[0]]
          arr
        end
      
        hist.sort! {|a, b| b[0] <=> a[0]}
      
        # now find all the ones that are tops
        most_frequent = []
        hist.each do |word|
          if most_frequent.empty? || most_frequent[-1][0] == word[0]
            most_frequent << word
          end
        end
      
        most_frequent[rand(most_frequent.length)][1]
      end
    
      def to_s
        ret = "#{@words.join(" ")} -> "
        @map.each do |k, v|
          ret << "#{k} (#{v}) "
        end
      
        ret
      end
    end
  end
end