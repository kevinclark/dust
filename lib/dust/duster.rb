module Dust
  class Duster < SexpProcessor
    attr_accessor :warnings
    
    def initialize(klass, meth)
      super()
      self.auto_shift_type = true
      self.strict = false
      self.expected = Array
      
      @class = klass
      @method = meth
      @warnings = []
    end
    
    def dust!
      process(ParseTree.translate(@class, @method))
    end
    
    def warn(warning)
      @warnings << warning
    end
    
    def process_defn(exp)
      method = exp.shift
      result = s(:defn, method)
      result << process(exp.shift) until exp.empty?

      result
    end
  end
end
