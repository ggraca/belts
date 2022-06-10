module BeltsOpengl
  class InputManager
    INPUT_MAP = {
      GLFW::KEY_W => :w,
      GLFW::KEY_A => :a,
      GLFW::KEY_S => :s,
      GLFW::KEY_D => :d,
    }

    def initialize(game, window)
      @game = game
      @window = window
      @input_changes = {}
    end

    def update
      register_callback
      @game.input.update(@input_changes)
      @input_changes = {}
    end

    private

    # NOTE: register_callback should be happening on initialisation. However, there's a bug that makes it throw a
    # segfault or stack overflow during PollEvents(). This might be at the gem level or OS. Seems to work fine when
    # the callback was just declared, hence why we're keeping it on the update function in order to move on.
    def register_callback
      key_callback = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
        key = INPUT_MAP[key]

        next if key.nil?
        next if action == GLFW::REPEAT

        @input_changes[key] = action == GLFW::PRESS
        pp @input_changes
      end

      GLFW.SetKeyCallback(@window, key_callback);
    end
  end
end
