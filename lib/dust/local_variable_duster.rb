require 'pp'

module Dust
  class LocalVariableDuster < SexpProcessor
    def initialize(klass, meth)
      super()
      self.auto_shift_type = true
      self.strict = false
      self.expected = Array
      @class = klass
      @method = meth
      @uses = Hash.new(0)
      @warnings = []
    end
    
    def dust!
      process(ParseTree.translate(@class, @method))
      
      @uses.select {|k,v| v < 2 }.each do |name, times|
        @warnings << UnusedVariableWarning.new(name)
      end
    end
    
    def warnings
      @warnings
    end
    
    def uses(name)
      @uses[name] || 0
    end
    
    def use(name)
      @uses[name] += 1
    end
    
    def process_defn(exp)
      method = exp.shift
      result = s(:defn, method)
      result << process(exp.shift) until exp.empty?

      result
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
  
  class UnusedVariableWarning
    attr_reader :method
    
    def initialize(meth)
      @method = meth
    end
    
    def ==(other)
      @method == other.method
    end
  end
end