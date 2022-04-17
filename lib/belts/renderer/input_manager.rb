module Belts
  class Renderer
    class InputManager
      def initialize(game, window)
        @game = game

        map = {
          GLFW::KEY_W => :w,
          GLFW::KEY_A => :a,
          GLFW::KEY_S => :s,
          GLFW::KEY_D => :d,
        }

        @input_changes = {}
        key_callback = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
          # next if INPUT_MAP[key].nil?
          # next if action == GLFW::REPEAT

          # key = INPUT_MAP[key]
          # input_changes[key] = action == GLFW::PRESS
        end

        GLFW.SetKeyCallback(window, key_callback);
      end

      def update
        @game.input.update(@input_changes)
        @input_changes = {}
      end
    end
  end
end
