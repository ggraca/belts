module BeltsCore
  module Tools
    class Input
      class Keyboard
        KEYS = [:w, :a, :s, :d, :q, :e, :space].freeze

        def initialize
          @state = KEYS.map { |id| [id, false] }.to_h
          @previous_state = @state.dup
        end

        def key(id) = KeyState.new(@state[id], @previous_state[id])

        def key?(id) = key(id).held?

        def update(changes)
          @previous_state = @state.dup
          @state.merge!(changes)
        end
      end
    end
  end
end
