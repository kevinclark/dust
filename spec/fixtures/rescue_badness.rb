module Fixtures
  class RescueBadness
    def rescue_nil
      raise rescue nil
    end
    
    def rescue_exception
    rescue Exception
    end
    
    def rescue_object
    rescue Object
    end
  end
end