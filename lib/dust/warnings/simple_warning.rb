module Dust
  module Warnings
    class SimpleWarning
      def self.discover(args = [])
        warning = new(*args)
        warning if warning.matches?
      end
      
      def matches?
        false
      end
      
      def ==(other)
        other.is_a? self.class
      end
    end
  end
end
