module Enumerable

def my_each(*arg)
      return to_enum(:my_each) if !block_given? || arg==nil
      arg = 0
      while arg < self.size
            yield self[arg] if self.is_a?(Array)
      # p self
            yield self.to_a[arg] if self.is_a?(Hash)
      # p self
            yield self.to_a[arg] if self.is_a?(Range) 
            arg += 1
      end
end
# def my_each_with_index(*arg)
#       return to_enum(:my_each_with_index) if !block_given? || arg==nil
#       arg = 0
#       idx = self.index
#       arg.to_s if arg.is_a?(Integer)
#       while arg < self.size
#             yield self[arg], idx if self.is_a?(Array)
#             arg+=1
#             idx= self[idx+1]
#       end
# end
end


arr=["hi","hello","ciao",1,2,3] 
arr.my_each("ciao") {|n| puts "#{ n.is_a?(Integer) ?(puts n+2) : (puts n)}"}

obj={first: "first", second: 42, third: [1,2,3,4], fourth:{nested:"inside hash"} }
obj.my_each {|key,value| puts "#{key} key value is: #{value}"}
(1..5).my_each {|n| puts n*5}
# arr.my_each_with_index {|index,value| "#{value} is at index : #{index}"}
