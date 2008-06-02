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
  end
end
