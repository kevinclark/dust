module Dust
  class ArgumentDuster < LocalVariableCounter
    def dust!
      super
      
      @lvars.each do |name, details|
        next if details[:calls] > 0
        next if details[:uses] >= 2
        warn Warnings::UnusedArgument.new(name)
      end
    end
    
    def process_args(args)
      args.size.times do
        use args.shift.to_s.gsub(/^\*/, '').to_sym
      end
      
      s(:args, *args)
    end
  end
end
