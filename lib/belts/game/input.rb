module Belts
  class Game
    class Input
      KEYS = [:a, :d].freeze

      def initialize
        @current_state = KEYS.map { |key| [key, false] }.to_h
        @last_state = @current_state.dup
      end

      def update(changes)
        @last_state = @current_state.dup
        @current_state.merge!(changes)
      end

      def key?(key)
        @current_state[key]
      end

      def key_up?(key)
        !@current_state[:key] && @last_state[:key]
      end

      def key_down?(key)
        @current_state[:key] && !@last_state[:key]
      end
    end
  end
end
