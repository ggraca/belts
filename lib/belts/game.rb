module Belts
  class Game
    attr_reader :time, :input, :window, :entities, :systems, :asset_manager, :current_scene

    def initialize
      @time = Game::Time.new
      @input = Game::Input.new
      @window = Game::Window.new
      @entities = Ecs::EntityManager.new

      # Needs game to pass it to the systems and to register the collections
      @systems = Ecs::SystemManager.new(self)

      # Needs game to register and access assets (shaders) and access entities / collections. Can be removed once systems are implemented
      @renderer = Renderer.new(self)
      @asset_manager = Assets::AssetManager.new

      # Needs game to instantite entities
      @current_scene = MainScene.new(self) # TODO: Game specific
    end

    def update
      @time.update
      @systems.update
      @renderer.update
    end
  end
end
