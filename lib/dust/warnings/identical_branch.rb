module Dust
  module Warnings
    class IdenticalBranch < SimpleWarning
      attr_reader :yes_branch, :no_branch
      def initialize(*args)
        @cond, @yes_branch, @no_branch = args
      end
        
      def matches?
        yes_branch == no_branch
      end
      
      def message
        "The branches of if (#{sexp_to_ruby(@cond)}) are identical."
      end
    end
  end
end
