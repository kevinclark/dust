module Dust
  module Warnings
    class RescueEverything < SimpleWarning
      def initialize(*args)
        @exceptions, @rescue_value = args
      end
      
      def matches?
        return false unless @exceptions
        [:Object, :Exception].find do |const|
          @exceptions.include? [:const, const]
        end
      end
      
      def message
        "A rescue is capturing Object or Exception, which may hide errors."
      end
    end
  end
end