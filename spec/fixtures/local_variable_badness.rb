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
  end
end
