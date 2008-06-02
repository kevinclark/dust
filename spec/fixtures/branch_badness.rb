module Fixtures
  class BranchBadness
    def branch_returning_true_or_false
      if 1 == 2
        true
      else
        false
      end
    end
  end
end
