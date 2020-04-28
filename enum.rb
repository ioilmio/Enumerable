module Enumerable

def my_each
      return to_enum(:my_each) if !block_given? 
      item = 0
      while item < self.size
            yield self[item] if self.is_a?(Array)
      # p self
            yield self.to_a[item] if self.is_a?(Hash)
      # p self
            yield self.to_a[item] if self.is_a?(Range) 
            item += 1
      end
end
def my_each_with_index
      return to_enum(:my_each_with_index) if !block_given?
      idx = 0
      item = 0
      while item < self.size
            yield self[item], idx
            item+=1
            idx+=1
      end
end
end


arr=["hi","hello","ciao",1,2,3] 
arr.my_each {|n| puts "#{n}"}

obj={first: "uno", second: 42, third: [1,2,3,4], fourth:{nested:"inside hash"} }
obj.my_each {|key,value| puts "#{key} key value is: #{value}"}
(1..5).my_each {|n| puts n*5}
arr.my_each_with_index {|value,index| puts "#{value} is at index : #{index}"}
