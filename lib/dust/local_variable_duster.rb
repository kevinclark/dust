module Dust
  class LocalVariableDuster < LocalVariableCounter
    def dust!
      super
      
      @lvars.each do |name, details|
        next if @args.include? name
        next if details[:calls] > 0
        # The first assignment is a use
        next if details[:uses] > 1
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