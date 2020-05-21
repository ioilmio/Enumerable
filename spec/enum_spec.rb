require_relative '../enum.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }
  let(:hash) { { string: 'value1', number: 2 } }
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
end # describe enum
