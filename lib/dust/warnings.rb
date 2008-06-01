module Dust
  module Warnings
    class SimpleWarning; end
    
    class UnusedVariable < SimpleWarning
      attr_reader :variable

      def initialize(variable)
        @variable = variable
      end

      def ==(other)
        @variable == other.variable
      end
    end
    
    
    class NullStatement < SimpleWarning
      attr_reader :node, :details
      
      def initialize(node, details = {})
        @node = node
        @details = details
      end
      
      def ==(other)
        node == other.node
        details == other.details
      end
    end
    
    class UnprotectedBlock < SimpleWarning
      def ==(other)
        other.is_a? self.class
      end
    end
  end
end
