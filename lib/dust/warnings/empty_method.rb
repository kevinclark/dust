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
    end
  end
end