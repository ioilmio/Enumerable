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

  def my_select
    return to_enum(:my_select) unless block_given?

    if is_a?(Array)
      selected = []
      my_each do |item|
        selected.push(item) if yield(item) == true
      end
    else
      selected = {}
      my_each do |key, value|
        selected[key] = value if yield(key, value) == true
      end
    end
    selected
  end

  def my_all?(*)
    return true unless block_given?

    result = true
    my_each do |item|
      result = false unless yield item
    end
    result
  end

  def my_any?(*)
    return true unless block_given?

    result = false
    my_each do |item|
      result = true unless yield item
    end
    result
  end

  def my_none?(*)
    return true unless block_given?

    result = true
    my_each do |item|
      result = false unless yield item
    end
    result
  end

  def my_count
    counter = 0
    my_each { |value| counter += 1 if yield value }
    counter
  end

  # module end
end

# arr = ['hi', 'hello', 'ciao', 1, 2, 3]
array = [12, 3, 4, 5, 6]
# friends = %w[Patatina Anna Roby Mara Andrea Maria Mimmo Marco]
# friends.my_all?(String) { |friend| friend.length >= 5 }
puts(array.my_all? { |n| n > 5 })
puts(array.my_any? { |n| n > 5 })
puts(array.my_none? { |n| n < 40 })
puts(array.my_count { |x| x < 2 })

# arr.my_each { |n| puts n.to_s }

# obj = { first: 'uno', second: 42, third: [1, 2, 3, 4], fourth: { nested: 'inside hash' } }
# obj.my_each { |key, value| puts "#{key} key value is: #{value}" }

# (1..5).my_each { |n| puts n * 5 }

# arr.my_each_with_index { |value, index| puts value if index.even? }
# puts(array.my_select { |n| n < 5 })
# puts(friends.my_select { |friend| friend[0] == "P" })

# puts(obj.my_select { |_key, value| value == "uno" })
