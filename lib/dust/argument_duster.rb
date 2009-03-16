module Dust
  class ArgumentDuster < LocalVariableCounter
    def dust!
      @silence_warnings = false
      super
      return if @silence_warnings
      
      @lvars.each do |name, details|
        next if details[:calls] > 0
        next if details[:uses] >= 2
        next if !@args.include?(name)
        warn Warnings::UnusedArgument.new(name)
      end
    end
    
    def process_zsuper(exp)
      @silence_warnings = true
      s(:zsuper)
    end
  end
end
