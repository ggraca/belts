module BeltsCore
  module Tools
    class Input
      class KeyState
        def initialize(pressed, previously_pressed)
          @pressed = pressed
          @previously_pressed = previously_pressed
        end

        def up? = !@pressed && @previously_pressed

        def down? = @pressed && !@previously_pressed

        def held? = @pressed && @previously_pressed
      end
    end
  end
end
