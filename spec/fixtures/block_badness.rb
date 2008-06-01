module Fixtures
  class BlockBadness
    def no_conditional_for_block_given
      yield
    end
    
    def simple_check_for_block_given
      yield if block_given?
    end
    
    def simple_conditional_without_check
      if true
        yield
      end
    end
    
    def complex_conditional_with_check(var)
      if (1 + 2 == var) && block_given?
        yield
      end
    end
  end
end
