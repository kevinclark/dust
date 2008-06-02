module Dust
  module Warnings
    class SimpleWarning
      def self.discover(args = [])
        warning = new(*args)
        warning if warning.matches?
      end
    end
  end
end
