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
          #                     label,  args,                                     splats,       ..
          # :masgns look like [:masgn, [:array, [:dasgn_curr, :x]],               [:lasgn, :a], nil]
          #         or        [:masgn, nil,                                       [:lasgn, :a], nil]
          #         or        [:masgn, [:array, [:dasgn_curr, :x], [:lasgn, :a]], nil,          nil]
          
          to_check = []
          
          assigns = @block_vars[1].deep_clone
          if assigns
            assigns.shift # bump the array
            to_check += assigns
          end
          
          to_check += s(@block_vars[2].deep_clone) if @block_vars[2]
          
          to_check.each do |sexp|
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
      
      def message
        "One or more variable(s) are being shadowed (#{@vars.to_a.join(',')})"
      end
    end
  end
end
