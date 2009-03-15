module Dust
  module Warnings
    class RescueValue < SimpleWarning
      def initialize(*args)
        @exceptions, *@rescue_value = args
      end
      
      def matches?
        return false if @rescue_value.nil?
        return false if @rescue_value.size > 1
        return false if @rescue_value.empty?
        val = @rescue_value.first
        return false if val.nil? or val.empty?
        [:lit, :nil].include? val.first # the value's type
      end
      
      def message
        "A rescue is returning #{sexp_to_ruby(@rescue_value.first).inspect} directly and may not handle an error."
      end
    end
  end
end