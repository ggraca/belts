module BeltsEngine
  module Tools
    class Input
      module Keyboard
        KEYS = [:w, :a, :s, :d].freeze

        def key?(key) = @keyboard_state[key]

        def key_down?(key) = @keyboard_state[key] && !@keyboard_previous_state[key]

        def key_up?(key) = !@keyboard_state[key] && @keyboard_previous_state[key]

        def update_keys(changes)
          @keyboard_previous_state = @keyboard_state.dup
          @keyboard_state.merge!(changes)
        end

        private

        def reset_keyboard_state
          @keyboard_state = KEYS.map { |key| [key, false] }.to_h
          @keyboard_previous_state = @keyboard_state.dup
        end
      end
    end
  end
end
