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
      
      def message
        "The argument #{@argument.inspect} is unused."
      end
    end
  end
end
