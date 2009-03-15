module Dust
  module Warnings
    class UselessBranch < SimpleWarning
      attr_reader :yes_branch, :no_branch
  
      def initialize(*args)
        @yes_branch, @no_branch = args
      end
    
      def matches?
        (yes_branch == s(:true) and no_branch == s(:false)) or
          (yes_branch == s(:false) and no_branch == s(:true))
      end
      
      def message
        "A conditional returns only 'true' or 'false'. Return the condition instead."
      end
    end
  end
end