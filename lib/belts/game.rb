module Belts
  class Game
    attr_reader :time, :input, :asset_manager, :current_scene

    def initialize
      @time = Game::Time.new
      @input = Game::Input.new

      @renderer = Renderer.new(self)
      @asset_manager = Assets::AssetManager.new

      @current_scene = MainScene.new(self) # TODO: Game specific
    end

    def update
      @time.update
      @current_scene.update
      @renderer.update
    end
  end
end
