require 'zeitwerk'
require 'belts_support'
require 'opengl'
require 'glfw'

loader = Zeitwerk::Loader.for_gem
loader.setup

module BeltsOpengl
  extend BeltsSupport::Extension

  def self.install(game)
    require 'belts_opengl/components/camera_data'
    require 'belts_opengl/components/light_data'
    require 'belts_opengl/components/render_data'

    require 'belts_opengl/systems/window_system'
    require 'belts_opengl/systems/render_system'

    GLFW.load_lib()
    GLFW.Init()
    GL.load_lib()

    game.systems.register_system(BeltsOpengl::WindowSystem)
    game.systems.register_system(BeltsOpengl::RenderSystem)
  end
end
