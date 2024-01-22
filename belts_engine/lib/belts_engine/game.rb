module BeltsEngine
  class Game
    include BeltsSupport::Configuration
    include BeltsEngine::ToolsManager

    def initialize
      @running = true
      register_tool(:time, Tools::Time.new)
      register_tool(:ecs, Tools::Ecs.new(self))
      register_tool(:scenes, Tools::SceneManager.new(self))
    end

    def start
      ecs.init_systems
      ecs.start_systems

      main_scene_class = config.main_scene.to_s.constantize
      raise "Main scene not specified" unless main_scene_class

      scenes.load_scene(main_scene_class)
    end

    def update
      time.update
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
