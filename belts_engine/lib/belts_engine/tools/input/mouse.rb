module BeltsEngine
  module Tools
    class Input
      module Mouse
        BUTTONS = [:mouse_1, :mouse_2, :mouse_3].freeze

        def button?(button) = @mouse_state[button]

        def button_down?(button) = @mouse_state[button] && !@mouse_previous_state[button]

        def button_up?(button) = !@mouse_state[button] && @mouse_previous_state[button]

        def mouse(axis) = @mouse_state[axis]

        def update_buttons(changes)
          @mouse_previous_state = @mouse_state.dup
          @mouse_state.merge!(changes)
        end

        def update_position(x, y)
          @mouse_state[:x] = x
          @mouse_state[:y] = y
        end

        private

        def reset_mouse_state
          @mouse_state = BUTTONS.map { |button| [button, false] }.to_h
          @mouse_state[:x] = @mouse_state[:y] = 0
          @mouse_previous_state = @mouse_state.dup
        end
      end
    end
  end
end
