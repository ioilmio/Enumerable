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

  def my_all?(arg = nil) # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
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
    elsif block_given?
      my_each do |item|
        return false unless yield item
      end
    end
    true
  end

  def my_any?(arg = nil) # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
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
    elsif block_given?
      my_each do |item|
        return true if yield item
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
    result = []
    if block_given?
      my_each { |item| result.push(yield(item)) } unless proc
      my_each { |item| result << proc.call(item) } if proc
    elsif proc
      my_each { |item| result << proc.call(item) }
    else
      return to_enum
    end
    result
  end

  def my_inject(memo = nil, symbol = nil, &proc)
    proc = symbol.to_proc if symbol.is_a?(Symbol)
    if memo.is_a?(Symbol)
      proc = memo.to_proc
      memo = nil
    end
    my_each do |item|
      memo = memo.nil? ? item : proc.call(memo, item)
    end
    memo
  end
end

def multiply_els(array)
  p(array.my_inject { |product, i| product * i })
end

multiply_els([2, 4, 5])
