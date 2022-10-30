module BeltsEngine
  class Game
    include BeltsSupport::Configuration
    include BeltsEngine::ToolsManager

    def initialize
      @running = true
      register_tool(:time, Tools::Time.new)
      register_tool(:input, Tools::Input.new)
      register_tool(:window, Tools::Window.new)
      register_tool(:collections, Ecs::CollectionManager.new)
      register_tool(:entities, Ecs::EntityManager.new(self))
      register_tool(:scenes, Tools::SceneManager.new(self))
      register_tool(:systems, Ecs::SystemManager.new(self))
      register_tool(:assets, Tools::AssetManager.new)
    end

    def start
      assets.meshes.add_mesh(:cube, *Tools::AssetManager::DefaultMeshes.cube)
      assets.meshes.add_mesh(:square, *Tools::AssetManager::DefaultMeshes.square)
      assets.meshes.add_mesh(:triangle, *Tools::AssetManager::DefaultMeshes.triangle)

      main_scene_class = config.main_scene.to_s.constantize
      raise "Main scene not specified" unless main_scene_class

      scenes.load_scene(main_scene_class)
    end

    def update
      time.update
      systems.update
    end

    def running?
      @running
    end

    def stop
      @running = false
    end

    def quit
    end
  end
end
