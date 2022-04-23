module Belts
  class Game
    attr_reader :time, :input, :window, :entities, :systems, :asset_manager, :current_scene

    def initialize
      @time = Game::Time.new
      @input = Game::Input.new
      @window = Game::Window.new
      @entities = Ecs::EntityManager.new
      @systems = Ecs::SystemManager.new(self)
    end

    def use(extension)
      extension.install(self)
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
