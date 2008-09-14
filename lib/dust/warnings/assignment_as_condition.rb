module Dust
  module Warnings
    class AssignmentAsCondition < SimpleWarning
      ASSIGNMENT_NODES = [:lasgn, :op_asgn_or, :op_asgn_and, :iasgn,
                          :op_asgn1, :gasgn, :dasgn_curr]
      
      attr_reader :condition
      
      def initialize(*args)
        @condition = args.shift
      end
        
      def matches?
        ASSIGNMENT_NODES.include? @condition.first
      end
    end
  end
end
