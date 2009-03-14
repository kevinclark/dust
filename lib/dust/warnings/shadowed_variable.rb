require 'set'

module Dust
  module Warnings
    class ShadowedVariable < SimpleWarning
      attr_reader :vars
      
      # ShadowedVariable.new takes one or more block variable assignment sexps
      def initialize(*args)
        @block_vars = args.shift
        @vars = Set.new
      end
        
      def matches?
        case @block_vars && @block_vars.first
        when :masgn
          matched = false
          # :masgns look like (:masgn, (:array, stuff...))
          assignments = @block_vars[1].deep_clone
          assignments.shift # bump the array
          assignments.each do |sexp|
            next unless sexp.first == :lasgn
            vars << sexp[1]
            matched = true
          end
          matched
        when :lasgn
          vars << @block_vars[1]
          true
        end
      end
    end
  end
end
