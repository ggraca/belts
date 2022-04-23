module Belts
  class Renderer
    def initialize(game)
      @game = game

      GLFW.load_lib()
      GLFW.Init()
      GL.load_lib()

      @game.systems.register_system(Renderer::WindowSystem)
      @game.systems.register_system(Renderer::RenderSystem)

      # NOTE: This causes a segfault. Waiting for it to get fixed.
      # @input_manager = InputManager.new(@game, @window)
    end
  end
end
