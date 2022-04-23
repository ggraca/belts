module Belts
  class Game
    attr_reader :time, :input, :window, :entities, :systems, :asset_manager, :current_scene

    def initialize
      @time = Game::Time.new
      @input = Game::Input.new
      @window = Game::Window.new
      @entities = Ecs::EntityManager.new
      @systems = Ecs::SystemManager.new(self)

      install_plugins
      load_assets
      start
    end

    def install_plugins
      # Needs game to register and access assets (shaders) and access entities / collections. Can be removed once systems are implemented
      @renderer = Renderer.new(self)
    end

    def load_assets
      @asset_manager = Assets::AssetManager.new
    end

    def start
      # Needs game to instantite entities
      @current_scene = MainScene.new(self) # TODO: Game specific
    end

    def update
      @time.update
      @systems.update
    end
  end
end
