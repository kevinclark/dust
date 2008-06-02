module Dust
  module Warnings
    class IdenticalBranch < SimpleWarning
      attr_reader :yes_branch, :no_branch
      def initialize(*args)
        @yes_branch, @no_branch = args
      end
        
      def matches?
        yes_branch == no_branch
      end
      
      def ==(other)
        other.is_a? self.class
      end
    end
  end
end
