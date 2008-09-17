module Dust
  module Warnings
    class ShadowedVariable < SimpleWarning
      def initialize(*args)
        @block_vars = args.shift
      end
        
      def matches?
        case @block_vars.first
        when :masgn
          # :masgns look like (:masgn, (:array, stuff...))
          assignments = @block_vars.last.deep_clone
          assignments.shift # bump the array
          assignments.any? {|sexp| sexp.first == :lasgn }
        when :lasgn
          true
        end
      end
    end
  end
end
