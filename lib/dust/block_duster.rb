module Dust
  class BlockDuster < Duster
    def initialize(klass, meth)
      super
      
      @checked_for_block = false
      @calls_yield = false
    end
    
    def checked_for_block?
      @checked_for_block
    end
    
    def process_if(exp)
      cond = exp.shift
      yes_block = exp.shift
      no_block = exp.shift
      
      if Sexp.from_array(yes_block) =~ s(:yield) && 
         Sexp.from_array(cond) !~ s(:fcall, :block_given?)
        warn Warnings::UnprotectedBlock.new
      end
      
      s(:if, cond, yes_block, no_block)
    end
    
    def process_yield(exp)
      warn Warnings::UnprotectedBlock.new
      
      s(:yield)
    end
  end
end
