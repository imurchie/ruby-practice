#!/usr/bin/env ruby
# encoding: utf-8



# implementation of the "stack" ADT
# methods: push, pop, top, empty?, length
# basically amounts to the Adapter pattern around an Array

class Stack
  def initialize(enum = [])
    @array = []
    enum.each { |e| @array << (e.instance_of?(Array) ? e[0].clone : e.clone) }
  end
  
  def push(element)
    @array.push(element)
  end
  
  def pop
    @array.pop
  end
  
  def top
    @array[-1]
  end
  
  def empty?
    @array.empty?
  end
  
  def length
    @array.length
  end
end