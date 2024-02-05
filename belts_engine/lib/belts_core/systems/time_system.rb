module BeltsCore::Systems
  class TimeSystem < BeltsEngine::System
    phase :on_load

    def update
      @time.update
    end
  end
end
