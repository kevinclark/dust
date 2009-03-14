module Dust
  class MethodDuster < Duster
    def process_defn(exp)
      # def foo(x); 1 end =>
      #   [:defn, :foo, [:scope, [:block, [:args, :x], [:lit, 1]]]]
      name, (_scope, (_block, (_argsym, *args), body)) = exp

      scan_for [Warnings::EmptyMethod],
           :with => [name, args, body]
      
      super
    end
  end
end
