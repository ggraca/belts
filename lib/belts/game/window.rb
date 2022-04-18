module Belts
  class Game
    class Window
      attr_reader :ratio, :width, :height, :title

      DEFAULT_WIDTH = 640
      DEFAULT_HEIGHT = 480
      DEFAULT_TITLE = 'Belts Demo'.freeze

      def initialize
        @title = DEFAULT_TITLE
        resize(DEFAULT_WIDTH, DEFAULT_HEIGHT)
      end

      def resize(width, height)
        @width = width
        @height = height
        @ratio = @width.to_f / @height.to_f
      end
    end
  end
end
