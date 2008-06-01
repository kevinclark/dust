module Dust
  class LocalVariableDuster < Duster
    def initialize(klass, meth)
      super
      @lvars = Hash.new {|h,k| h[k] = {:uses => 0, :calls => 0}}
      @uses = Hash.new(0)
      @sends = Hash.new(0)
    end

    def dust!
      super
      
      @lvars.each do |name, details|
        next if details[:calls] > 0
        next if details[:uses] >= 2
        warn Warnings::UnusedVariable.new(name)
      end
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
      
      exp
    end
    
    def process_call(exp)
      recv = process(exp.shift)
      meth = exp.shift
      args = process(exp.shift)

      call recv.last if recv.first == :lvar
      
      exp
    end
    
    def process_lvar(exp)
      name = exp.shift
      use name
      [:lvar, name]
    end
  end
end