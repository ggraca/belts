require "belts_engine"
require "opengl"
require "glfw"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "belts_opengl" => "BeltsOpenGL"
loader.setup

module BeltsOpenGL
  extend BeltsSupport::Extension

  def self.install(game)
    require "belts_opengl/systems/window_system"
    require "belts_opengl/systems/render_system"

    GLFW.load_lib
    GLFW.Init
    GL.load_lib

    game.systems.register_system(BeltsOpenGL::WindowSystem)
    game.systems.register_system(BeltsOpenGL::RenderSystem)

    game.assets.meshes.register_loader(:opengl, BeltsOpenGL::Assets::MeshLoader)
    game.register_tool(:opengl_shaders, BeltsOpenGL::Tools::ShaderManager.new)

    BeltsEngine::Prefab.include BeltsOpenGL::Prefab::RendererMixin
  end

  def self.root
    File.dirname __dir__
  end
end
