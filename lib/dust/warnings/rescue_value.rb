module Dust
  module Warnings
    class RescueValue < SimpleWarning
      def initialize(*args)
        @exceptions, @rescue_value = args
      end
      
      def matches?
        @rescue_value
      end
    end
  end
end