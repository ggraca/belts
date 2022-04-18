module Belts
  class Renderer
    def initialize(game)
      @game = game

      GLFW.load_lib()
      GLFW.Init()
      GLFW.WindowHint(GLFW::ALPHA_BITS, 0)
      @window = GLFW.CreateWindow(640, 480, "Belts Demo", nil, nil)
      GLFW.MakeContextCurrent(@window)

      # NOTE: This causes a segfault. Waiting for it to get fixed.
      # @input_manager = InputManager.new(@game, @window)

      GL.load_lib()
      GL.Enable(GL::DEPTH_TEST)
      GL.Enable(GL::CULL_FACE)

      @game.systems.register_system(Renderer::RendererSystem)
    end

    def update
      update_window_size
      GLFW.SwapBuffers(@window)
      GLFW.PollEvents()
    end

    private

    def update_window_size
      width_ptr = ' ' * 8
      height_ptr = ' ' * 8
      GLFW.GetFramebufferSize(@window, width_ptr, height_ptr)
      width = width_ptr.unpack('L')[0]
      height = height_ptr.unpack('L')[0]
      GL.Viewport(0, 0, width, height)

      @game.window.resize(width, height)
    end
  end
end
