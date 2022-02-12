class Game
  attr_reader :asset_manager, :current_scene

  def initialize
    @renderer = Renderer.new(self)
    @asset_manager = AssetManager.new
    @current_scene = SnakeScene.new(self)
  end

  def update
    @current_scene.update
    @renderer.update
  end
end
