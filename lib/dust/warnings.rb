module Dust
  module Warnings
    class UnusedVariable
      attr_reader :variable

      def initialize(variable)
        @variable = variable
      end

      def ==(other)
        @variable == other.variable
      end
    end
    
    
    class NullStatement
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
  end
end
