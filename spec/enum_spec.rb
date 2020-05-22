require_relative '../enum.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }
  let(:hash) { { string: 'value1', number: 2 } }
  let(:str_arr) { %w[ant beat cat] }
  let(:empty_array) { [] }
  describe '#my_each' do
    it 'returns an enumerator if no block given' do
      expect(array.my_each.class).to eq(array.my_each.class)
    end
    it 'returns an each method output when a block is given' do
      expect(array.my_each { |item| puts item.to_s })
    end
  end
  describe '#my_each_with_index' do
    it 'returns an enumerator if no block given' do
      expect(array.my_each_with_index.class).to eq(array.my_each_with_index.class)
    end
    it 'returns item and index of the array if passed to the block' do
      expect(array.my_each_with_index { |item, index| puts "item #{item} is at index #{index}" })
    end
  end
  describe '#my_select' do
    it 'returns an enumerator if no block given' do
      expect(array.my_select.class).to eq(array.my_select.class)
    end
    it 'returns an array with the selected item based on block parameters' do
      expect(array.my_select(&:even?)).to eq([2, 4])
    end
    it 'returns an hash with the selected item based on block parameters' do
      expect(hash.my_select { |_key, value| value == 2 }).to eq({ number: 2 })
    end
  end
  describe '#my_all?' do
    it 'returns true if not block given' do
      expect(array.my_all?).to eq(true)
    end
    it 'returns true if all elements in the enumerable are of the same class' do
      expect(array.my_all?(Integer)).to eq(true)
    end
    it 'returns true if all elements in the enumerable match the pattern provided in the RegEx' do
      expect(str_arr.my_all?(/t/)).to eq(true)
    end
    it 'returns true if all the elements in the enumerable are the same as the argument' do
      expect(array.my_all?(1)).to eq(false)
    end
    it 'returns true if all the elements in the enumerable satisfie the condition in the block' do
      expect(array.my_all? { |item| item < 10 }).to eq(true)
    end
  end
  describe '#my_any?' do
    it 'returns true if not block given' do
      expect(array.my_any?).to eq(true)
    end
    it 'returns true if any of the elements in the enumerable are of the same class' do
      expect(array.my_any?(Integer)).to eq(true)
    end
    it 'returns true if any of the elements in the enumerable match the pattern provided in the RegEx' do
      expect(str_arr.my_any?(/t/)).to eq(true)
    end
    it 'returns true if any of the the elements in the enumerable are the same as the argument' do
      expect(array.my_any?(1)).to eq(true)
    end
    it 'returns true if any of the the elements in the enumerable satisfie the condition in the block' do
      expect(array.my_any? { |item| item < 3 }).to eq(true)
    end
  end
  describe '#my_none?' do
    it 'returns true if not block given' do
      expect(empty_array.my_none?).to eq(true)
    end
    it 'returns true if none of the elements in the enumerable are of the same class' do
      expect(array.my_none?(String)).to eq(true)
    end
    it 'returns true if none of the elements in the enumerable match the pattern provided in the RegEx' do
      expect(str_arr.my_none?(/s/)).to eq(true)
    end
    it 'returns true if none of the elements in the enumerable are the same as the argument' do
      expect(array.my_none?(0)).to eq(true)
    end
    it 'returns true if none the elements in the enumerable satisfies the condition in the block' do
      expect(array.my_none? { |item| item > 10 }).to eq(true)
    end
  end
  describe '#my_count' do
    it 'returns the number of elements that matches the block condition' do
      expect(array.my_count(&:even?)).to eq(2)
    end
    it 'returns the number of elements that matches the argument' do
      expect(array.my_count(2)).to eq(1)
    end
    it 'returns the number of elements in the enumerable' do
      expect(array.my_count).to eq(4)
    end
  end
  describe '#my_map' do
    it 'returns an enumerator if no block is given' do
      expect(array.my_map.class).to eq(array.my_map.class)
    end
    it 'returns a new array with the results of running block once for every element in enum.' do
      expect(array.my_map { |item| item * 2 }).to eq([2, 4, 6, 8])
    end
  end
  describe '#my_inject' do
    it 'reduce all elements to a single value based on the symbol passed in' do
      expect(array.my_inject(:+)).to eq(10)
    end
    it 'reduce all elements to a single value based on the block passed in (as in multiply_els method)' do
      expect(array.my_inject { |product, i| product * i }).to eq(24)
    end
    it 'reduce all elements to a single value based on the arguments passed in' do
      expect(array.my_inject(1, :*)).to eq(24)
    end
    it 'reduce all elements to a single value based on the block passed in (using a string array)' do
      expect(str_arr.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq('beat')
    end
  end
end
