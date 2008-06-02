module Dust
  module Warnings
    class UnusedVariable < SimpleWarning
      attr_reader :variable

      def initialize(variable)
        @variable = variable
      end

      def ==(other)
        @variable == other.variable
      end
    end
    
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
