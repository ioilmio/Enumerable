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

  def my_count(arg = nil) # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    counter = 0
    if block_given? && arg.nil?
      my_each do |item|
        counter += 1 if yield(item)
      end
    elsif !block_given? && !arg.nil?
      my_each do |item|
        counter += 1 if arg == item
      end
    else
      my_each do
        counter += 1
      end
    end
    counter
  end

  def my_map(proc = nil)
    array = []
    if block_given?
      my_each { |i| array.push(yield(i)) } unless proc
      my_each { |i| array << proc.call(i) } if proc
    elsif proc
      my_each { |i| array << proc.call(i) }
    else
      return to_enum
    end
    array
  end

  def my_inject(arg)
    memo = arg || self[0] if is_a?(Array)
    my_each { |value| memo = yield(memo, value) }
    memo
  end
end
