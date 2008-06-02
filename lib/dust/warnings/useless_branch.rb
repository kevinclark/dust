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
  
      def ==(other)
        other.is_a? self.class
      end
    end
  end
end