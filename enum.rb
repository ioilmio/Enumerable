module Enumerable

      def my_each(*arg)
        return to_enum(:my_each) if !block_given? && arg==nil
         arg= 0
         while arg < self.size
            yield (self[arg]) if self.is_a?(Array)
            yield self if self.is_a?(Hash)
             arg+=1
         end
      end
end



arr=["hi","hello","ciao",1,2,3] 
obj={prima: "first" ,seconda: "second", terza:"third",quarta:"forth" }

arr.my_each(0) {|n| puts "#{n}"}
obj.my_each(0) {|key,value| puts "#{key}#{value}"}