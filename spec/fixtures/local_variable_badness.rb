module Fixtures
  class LocalVariableBadness
    def unused_lasgn
      bar = 4
      1 + 2
    end

    def used_lvar
      bar = 4
      bar + 4
    end
    
    def unused_lvar
      bar = 4
      bar
      1 + 2
    end
    
    def lvar_with_call(foo)
      foo.bar
    end
    
    def unused_arg(arg)
      1 + 2
    end
    
    def used_arg(arg)
      arg + 4
    end
    
    def lvar_with_iasgn
      foo = 1
      @bar = foo
    end
    
    def arg_with_iasgn(arg)
      @foo = arg
    end
    
    def lvar_shadowed
      x = 1
      yields_to do |x|
        something_else_happens_here
      end
      x + 1
    end
    
    def lvar_shadowed_many_block_vars
      x = 1
      yields_to do |p,d,q,x|
        something_else_happens_here
      end
      x + 1
    end
    
    def lvar_not_shadowed
      x = 1
      yields_to do |y|
        something_else_happens_here
      end
      x + 1
    end
  end
end
