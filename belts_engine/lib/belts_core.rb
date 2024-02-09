require "flecs"
require "glm"

module BeltsCore
  extend BeltsSupport::Extension

  config_accessor :flecs_lib_path, default: :libflecs
  config_accessor :cglm_lib_path, default: :libcglm

  def self.install
    Flecs.load_lib(config.flecs_lib_path)
    GLM.load_lib(config.cglm_lib_path)
  end

  def self.init(game)
    game.register_tool(:time, Tools::Time.new)
    game.register_tool(:input, Tools::Input.new)
    game.register_tool(:window, Tools::Window.new)
    game.register_tool(:scenes, Tools::SceneManager.new(game))
  end
end
