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
  end
end