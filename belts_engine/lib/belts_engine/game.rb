module BeltsEngine
  class Game
    include BeltsSupport::Configuration
    include BeltsEngine::ToolsManager

    def initialize
      @running = true
      register_tool(:time, Tools::Time.new)
      register_tool(:input, Tools::Input.new)
      register_tool(:window, Tools::Window.new)

      world = Flecs.ecs_init
      #Flecs.ecs_fini(world)
      enemy_tag = Flecs.ecs_new_id(world)
      entity = Flecs.ecs_new_id(world)

      pp Flecs.ecs_has_id(world, entity, enemy_tag)
      Flecs.ecs_add_id(world, entity, enemy_tag)
      pp Flecs.ecs_has_id(world, entity, enemy_tag)

      @system = Flecs::System.new
      @system[:callback] = ->(iter) {
        puts "Hello from system!"
      }
      move_system = Flecs.ecs_system_init(world, @system)
      Flecs.ecs_run(world, move_system, 0, nil)

      pp :yo


      register_tool(:collections, Ecs::CollectionManager.new)
      register_tool(:entities, Ecs::EntityManager.new(self))
      register_tool(:scenes, Tools::SceneManager.new(self))
      register_tool(:systems, Ecs::SystemManager.new(self))
    end

    def start
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
