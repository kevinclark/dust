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
  end
end
