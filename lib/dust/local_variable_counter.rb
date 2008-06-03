module Dust
  class LocalVariableCounter < Duster
    def initialize(klass, meth)
      super
      @lvars = Hash.new {|h,k| h[k] = {:uses => 0, :calls => 0}}
    end
    
    def uses(name)
      @lvars[name][:uses]
    end
    
    def use(name)
      @lvars[name][:uses] += 1
    end
    
    def call(name)
      @lvars[name][:calls] += 1
    end
    
    def process_lasgn(exp)
      name = exp.shift
      value = exp.shift
      
      use name
      
      s(:lasgn, name, value)
    end
    
    def process_call(exp)
      recv = process(exp.shift)
      meth = exp.shift
      args = process(exp.shift)

      call recv.last if recv.first == :lvar
      
      s(:call, recv, meth, args)
    end
    
    def process_lvar(exp)
      name = exp.shift
      use name
      s(:lvar, name)
    end
  end
end