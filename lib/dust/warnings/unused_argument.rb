module Dust
  module Warnings
    class UnusedArgument < SimpleWarning
      attr_reader :argument

      def initialize(arg)
        @argument = arg
      end

      def ==(other)
        @argument == other.argument
      end
    end
  end
end
