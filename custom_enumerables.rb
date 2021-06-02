require 'pry'

module Enumerable

  def my_each
    for i in 0..self.length-1
      yield self[i]
    end
  end

  def my_each_with_index
    for i in 0..self.length-1
      yield self[i], i
    end
  end

  def my_select
    result = []
    my_each { |item| result.push self[i] if yield self[i] }

    return result
  end

  def my_all?
    my_each { |item| return false unless yield item }
    return true
  end

  def my_any?
    my_each { |item| return true if yield item }
    return false
  end

  def my_none?
    my_each { |item| return false if yield item }
    return true
  end

  def my_count
    if block_given?
      count = 0
      my_each { |item| count += 1 if yield item }
      return count
    else
      return self.length
    end
  end

  def my_map(a_proc = nil)
    result = []

    unless a_proc == nil
      my_each do |item| 
        result.push a_proc.call(item)
      end
      puts "Proc was called"
    else
      my_each do |item| 
        result.push yield item
      end
      puts "Block was yielded to"
    end

    return result
  end

  def my_reduce
    accumulator = self[0]
    for i in 1..self.length-1
      accumulator = yield accumulator, self[i]
    end

    return accumulator
  end
end

def multiple_els(array)
  return array.reduce { |product, number| product * number }
end

numbers = [1,2,3,4,5]
friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

some_proc = Proc.new { |friend| friend.upcase }
shouting = friends.my_map(some_proc) { |friend| friend.upcase}
p shouting