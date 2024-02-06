module BeltsCore
  extend BeltsSupport::Extension

  def self.install
    Flecs.load_lib
    GLM.load_lib
  end

  def self.init(game)
    game.register_tool(:time, Tools::Time.new)
    game.register_tool(:input, Tools::Input.new)
    game.register_tool(:window, Tools::Window.new)
    game.register_tool(:scenes, Tools::SceneManager.new(game))
  end
end
