module Dust
  class RescueDuster < Duster
    def process_resbody(exp)
      exceptions = exp.shift
      rescue_value = exp.shift
      
      scan_for [Warnings::RescueValue],
           :with => [exceptions, rescue_value]
      
      s(:resbody, exceptions, rescue_value)
    end
  end
end
