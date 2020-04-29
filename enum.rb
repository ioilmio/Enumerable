module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    item = 0
    while item < size
      yield self[item] if is_a?(Array)
      yield to_a[item] if is_a?(Hash)
      yield to_a[item] if is_a?(Range)

      item += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    idx = 0
    item = 0
    while item < size
      yield self[item], idx
      item += 1
      idx += 1
    end
  end
end

arr = ['hi', 'hello', 'ciao', 1, 2, 3]
arr.my_each { |n| puts n.to_s }

obj = { first: 'uno', second: 42, third: [1, 2, 3, 4], fourth: { nested: 'inside hash' } }
obj.my_each { |key, value| puts "#{key} key value is: #{value}" }

(1..5).my_each { |n| puts n * 5 }

arr.my_each_with_index { |value, index| puts "#{value} is at index : #{index}" }
