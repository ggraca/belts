module BeltsEngine
  class Game
    include BeltsSupport::Configuration
    include BeltsEngine::ToolsManager

    def initialize
      @running = true
      register_tool(:ecs, Tools::Ecs.new(self))
    end

    def start
      ecs.init_systems
    end

    def update
      ecs.progress
    end

    def running?
      @running
    end

    def stop
      @running = false
    end

    def quit
      ecs.finalize
    end
  end
end
