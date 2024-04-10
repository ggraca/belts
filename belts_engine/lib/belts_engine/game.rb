module BeltsEngine
  class Game
    include BeltsEngine::ToolsManager
    include ActiveSupport::Configurable

    config_accessor :main_scene

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

    def shutdown
      ecs.finalize
    end
  end
end
