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
      args.each do |arg|
        next unless arg.is_a? Symbol
        use arg.to_s.gsub(/^\*/, '').to_sym
      end
      
      args.clear
      
      s(:args, *args)
    end
    
    def process_block_arg(exp)
      name = exp.shift
      @args << name
      use name
      s(:block_arg, name)
    end
  end
end
