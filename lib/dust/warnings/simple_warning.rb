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
      
      def message
        raise NotImplementedError
      end
      
      private
      
        def sexp_to_ruby(sexp)
          Ruby2Ruby.new.process(Unifier.new.process(sexp))
        end
    end
  end
end
