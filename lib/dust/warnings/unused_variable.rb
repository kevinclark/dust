module Dust
  module Warnings
    class UnusedVariable < SimpleWarning
      attr_reader :variable

      def initialize(variable)
        @variable = variable
      end

      def ==(other)
        other.is_a?(self.class) && @variable == other.variable
      end
    end
  end
end
