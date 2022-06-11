module BeltsEngine
  module Tools
    class Input
      include Keyboard
      include Mouse

      def initialize
        reset_keyboard_state
        # reset_mouse_state
        #@current_keys[:mouse_x] = @current_keys[:mouse_y] = 0
      end

      def update(changes)
        update_keys(changes)
      end
    end
  end
end
