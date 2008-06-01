module Dust
  class LocalVariableDuster < Duster
    def initialize(klass, meth)
      super

      @uses = Hash.new(0)
    end

    def dust!
      super
      
      @uses.select {|k,v| v < 2 }.each do |name, times|
        warn Warnings::UnusedVariable.new(name)
      end
    end
    
    def uses(name)
      @uses[name] || 0
    end
    
    def use(name)
      @uses[name] += 1
    end
    
    def process_lasgn(exp)
      name = exp.shift
      value = exp.shift
      
      use name
      
      exp
    end
    
    def process_lvar(exp)
      name = exp.shift
      use name
      exp
    end
  end
  
end