module Dust
  class BlockDuster < Duster
    def process_if(exp)
      cond = Sexp.from_array(exp.shift)
      yes_branch = Sexp.from_array(exp.shift)
      no_branch = Sexp.from_array(exp.shift)
      
      scan_for [Warnings::UnprotectedBlock],
           :with => [cond, yes_branch, no_branch]
      
      s(:if, cond, yes_branch, no_branch)
    end
    
    def process_yield(exp)
      warn Warnings::UnprotectedBlock.new
      
      s(:yield)
    end
  end
end
