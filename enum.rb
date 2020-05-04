module Enumerable # rubocop:disable Metrics/ModuleLength
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

  def my_all?(arg = nil) # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    if !block_given? && arg.nil?
      my_each do |item|
        return false unless item
      end
    elsif arg.is_a?(Class)
      my_each do |item|
        return false unless item.is_a?(arg)
      end
    elsif arg.is_a?(Regexp)
      my_each do |item|
        return false unless item.match(arg)
      end
    elsif arg
      my_each do |item|
        return false unless item == arg
      end
    end
    true
  end

  def my_any?(arg = nil) # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    if !block_given? && arg.nil?
      my_each do |item|
        return true if item
      end
    elsif arg.is_a?(Class)
      my_each do |item|
        return true if item.is_a? arg
      end
    elsif arg.is_a?(Regexp)
      my_each do |item|
        return true if item.match(arg)
      end
    elsif arg
      my_each do |item|
        return true if item == arg
      end
    end
    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(arg = nil)
    return length unless block_given? || !arg.nil?

    counter = 0
    unless arg.nil?
      my_each do |item|
        counter += 1 if item == arg
      end
    end
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

# array = [2, 4, 5]

# def multiply_els(array)
#   array.my_inject(1) { |product, num| product * num }
# end

# cube = proc { |n| n**3 }
# puts array.my_map_proc(cube)

# puts multiply_els([2, 4, 5])
print [5, 4, 1, 2, 4, 4].my_count
