module BeltsBGFX
  class InputManager
    KEY_MAP = {
      SDL::SDLK_w => :w,
      SDL::SDLK_a => :a,
      SDL::SDLK_s => :s,
      SDL::SDLK_d => :d,
      SDL::SDLK_q => :q,
      SDL::SDLK_e => :e,
      SDL::SDLK_SPACE => :space,
      SDL::SDLK_ESCAPE => :esc
    }

    BUTTON_MAP = {
      # GLFW::MOUSE_BUTTON_1 => :mouse_1,
      # GLFW::MOUSE_BUTTON_2 => :mouse_2,
      # GLFW::MOUSE_BUTTON_3 => :mouse_3
    }

    def initialize(game, window)
      @game = game
      @window = window
    end

    def update
      @input_changes = {}
      @game.input.mouse.update_motion(0, 0)
      parse_events
      @game.input.keyboard.update(@input_changes)
    end

    private

    def parse_events
      event = SDL::Event.new
      while SDL.PollEvent(event) != 0
        event_type = event[:common][:type]
        _event_timestamp = event[:common][:timestamp]

        case event_type
        when SDL::KEYDOWN
          sym = event[:key][:keysym][:sym]
          key = KEY_MAP[sym]
          next if key.nil?

          @input_changes[key] = true
        when SDL::KEYUP
          sym = event[:key][:keysym][:sym]
          key = KEY_MAP[sym]
          next if key.nil?

          @input_changes[key] = false
        when SDL::QUIT
          @game.stop
        when SDL::WINDOWEVENT
          evt = event[:window][:event]
          if evt == SDL::WINDOWEVENT_RESIZED
            @game.window.resize(event[:window][:data1], event[:window][:data2])
          end
        when SDL::MOUSEMOTION
          @game.input.mouse.update_position(event[:motion][:x], event[:motion][:y])
          @game.input.mouse.update_motion(event[:motion][:xrel], event[:motion][:yrel])
        end
      end
    end
  end
end
