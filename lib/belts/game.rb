module Belts
  class Game
    attr_reader :time, :input, :entities, :systems, :asset_manager, :current_scene

    def initialize
      @time = Game::Time.new
      @input = Game::Input.new
      @entities = Ecs::EntityManager.new
      @systems = Ecs::SystemManager.new(self)

      @renderer = Renderer.new(self)
      @asset_manager = Assets::AssetManager.new

      @current_scene = MainScene.new(self) # TODO: Game specific
    end

    def update
      @time.update
      @systems.update
      @renderer.update
    end
  end
end
