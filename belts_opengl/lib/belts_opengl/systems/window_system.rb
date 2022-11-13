module BeltsOpenGL
  class WindowSystem < BeltsEngine::System
    def start
      GLFW.WindowHint(GLFW::ALPHA_BITS, 0)
      @glfw_window = GLFW.CreateWindow(@window.width, @window.height, "Belts Demo", nil, nil)
      GLFW.MakeContextCurrent(@glfw_window)

      @input_manager = BeltsOpenGL::InputManager.new(@game, @glfw_window)
    end

    def update
      update_window_size

      GLFW.SwapBuffers(@glfw_window)
      GLFW.PollEvents()

      @input_manager.update
    end

    private

    def update_window_size
      width_ptr = " " * 8
      height_ptr = " " * 8
      GLFW.GetFramebufferSize(@glfw_window, width_ptr, height_ptr)

      width = width_ptr.unpack1("L")
      height = height_ptr.unpack1("L")
      GL.Viewport(0, 0, width, height)

      @game.window.resize(width, height)
    end
  end
end
