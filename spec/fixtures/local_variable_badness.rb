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
    
    def simple_unused_arg(other)
      -1
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
    
    def used_splat_arg(*args)
      args + 4
    end
    
    def args_used_with_splats(args)
      respond(*args)
    end
    
    def splat_args_used_with_splat(*args)
      respond(*args)
    end
    
    def default_args(args=false)
      args
    end
    
    def block_arg_unused(&block)
      1 + 2
    end
    
    def block_arg_called(&block)
      block.call
    end
    
    def block_arg_curried(&block)
      respond(&block)
    end
    
    def rescue_to_variable
      begin
      rescue => e
      end
    end
  end
end
