module Dust
  module Warnings
    class EmptyMethod < SimpleWarning
      attr_reader :body
  
      def initialize(*args)
        @name, @args, @body = args
      end
    
      def matches?
        @body == [:nil]
      end
      
      def message
        "The method #{@name.inspect} is empty."
      end
    end
  end
end