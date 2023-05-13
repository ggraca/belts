module BeltsEngine
  module Tools
    class Input
      class Mouse
        BUTTONS = [:mouse_1, :mouse_2, :mouse_3].freeze

        attr_accessor :position, :motion

        def initialize
          @state = BUTTONS.map { |button| [button, false] }.to_h
          @previous_state = @state.dup

          @position = update_position(0, 0)
          @motion = update_motion(0, 0)
        end

        def button(id) = KeyState.new(@state[id], @previous_state[id])

        def button?(id) = button(id).held?

        def update(changes)
          @previous_state = @state.dup
          @state.merge!(changes)
        end

        def update_position(x, y)
          @position = Vec2[x, y]
        end

        def update_motion(x, y)
          @motion = Vec2[x, y]
        end
      end
    end
  end
end
