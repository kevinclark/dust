module Dust
  class RescueDuster < Duster
    def process_resbody(exp)
      exceptions = exp.shift
      rescue_value = exp.shift
      
      scan_for [Warnings::RescueValue, Warnings::RescueEverything],
           :with => [exceptions, rescue_value]
      
      exp.clear

      s(:resbody, exceptions, rescue_value)
    end
  end
end
