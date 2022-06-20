module BeltsOpengl
  class WindowSystem < BeltsEngine::System
    def start
      GLFW.WindowHint(GLFW::ALPHA_BITS, 0)
      @window = GLFW.CreateWindow(640, 480, "Belts Demo", nil, nil)
      GLFW.MakeContextCurrent(@window)

      @input_manager = BeltsOpengl::InputManager.new(@game, @window)
    end

    def update
      update_window_size

      GLFW.SwapBuffers(@window)
      GLFW.PollEvents()

      @input_manager.update
    end

    private

    def update_window_size
      width_ptr = " " * 8
      height_ptr = " " * 8
      GLFW.GetFramebufferSize(@window, width_ptr, height_ptr)

      width = width_ptr.unpack1("L")
      height = height_ptr.unpack1("L")
      GL.Viewport(0, 0, width, height)

      @game.window.resize(width, height)
    end
  end
end
