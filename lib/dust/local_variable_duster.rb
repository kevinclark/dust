module Dust
  class LocalVariableDuster < LocalVariableCounter
    def dust!
      super
      
      @lvars.each do |name, details|
        next if details[:calls] > 0
        next if details[:uses] >= 2
        warn Warnings::UnusedVariable.new(name)
      end
    end
    
    def process_iter(exp)
      call = process(exp.shift)
      assignments = process(exp.shift)
      block = process(exp.shift)
      
      scan_for [Warnings::ShadowedVariable],
          :with => [assignments]
          
      s(:iter, call, assignments, block)
    end
  end
end