module BeltsOpengl
  class InputManager
    KEY_MAP = {
      GLFW::KEY_W => :w,
      GLFW::KEY_A => :a,
      GLFW::KEY_S => :s,
      GLFW::KEY_D => :d
    }

    BUTTON_MAP = {
      GLFW::MOUSE_BUTTON_1 => :mouse_1,
      GLFW::MOUSE_BUTTON_2 => :mouse_2,
      GLFW::MOUSE_BUTTON_3 => :mouse_3
    }

    def initialize(game, window)
      @game = game
      @window = window
      @input_changes = {}

      GLFW.SetKeyCallback(@window, key_callback)
      GLFW.SetCursorPosCallback(@window, cursor_callback)
      GLFW.SetMouseButtonCallback(@window, mouse_button_callback)
    end

    def update
      @game.input.update(@input_changes)
      @input_changes = {}
    end

    private

    # NOTE: registering the callbacks with memoization because the gem has an
    # issue keeping reference to a local variable or method call, resulting
    # in a segfault
    def key_callback
      @_key_callback ||= GLFW.create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
        key = KEY_MAP[key]

        next if key.nil?
        next if action == GLFW::REPEAT

        @input_changes[key] = action == GLFW::PRESS
      end
    end

    def cursor_callback
      @_cursor_callback ||= GLFW.create_callback(:GLFWcursorposfun) do |window, x, y|
        @input_changes[:mouse_x] = x
        @input_changes[:mouse_y] = y
      end
    end

    def mouse_button_callback
      @_mouse_button_callback ||= GLFW.create_callback(:GLFWmousebuttonfun) do |window, button, action, mods|
        button = BUTTON_MAP[button]

        next if button.nil?
        next if action == GLFW::REPEAT

        @input_changes[button] = action == GLFW::PRESS
      end
    end
  end
end
