module Fixtures
  class RescueBadness
    def rescue_nil
      raise rescue nil
    end
  end
end