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
      result = false if yield item
    end
    result
  end

  def my_count
    counter = 0
    my_each { |value| counter += 1 if yield value }
    counter
  end

  def my_map(*)
    return to_enum(:my_map) unless block_given?

    result = []
    my_each { |element| result << yield(element) }
    result
  end

  def my_map_proc(proc)
    result = []
    my_each { |item| result << proc.call(item) }
    result
  end

  def my_inject(arg)
    memo = arg || self[0] if is_a?(Array)
    my_each { |value| memo = yield(memo, value) }
    memo
  end
end

array = [2, 4, 5]

def multiply_els(array)
  array.my_inject(1) { |product, num| product * num }
end

cube = proc { |n| n**3 }
puts array.my_map_proc(cube)

puts multiply_els([2, 4, 5])
