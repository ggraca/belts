module Belts
  class Game
    attr_reader :time, :input, :asset_manager, :current_scene

    def initialize
      @renderer = Renderer.new(self)
      @asset_manager = Assets::AssetManager.new
      # @input = Game::Input.new

      @time = Game::Time.new
      @current_scene = MainScene.new(self) # TODO: Game specific
    end

    def update
      @time.update
      @current_scene.update
      @renderer.update
    end
  end
end
