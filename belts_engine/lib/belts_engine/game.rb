module BeltsEngine
  class Game
    include BeltsSupport::Configuration
    include BeltsEngine::ToolsManager

    attr_reader :entities, :systems, :current_scene

    def initialize
      register_tool(:time, Game::Time.new)
      register_tool(:input, Game::Input.new)
      register_tool(:window, Game::Window.new)
      @entities = Ecs::EntityManager.new
      @systems = Ecs::SystemManager.new(self)
    end

    def use(extension)
      extension.install(self)
    end

    def start
      main_scene_class = config.main_scene.to_s.constantize
      raise 'Main scene not specified' unless main_scene_class

      @current_scene = main_scene_class.new(self)
    end

    def update
      time.update
      @systems.update
    end
  end
end
