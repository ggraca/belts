module BeltsCore
  module Tools
    class Input
      attr_accessor :keyboard, :mouse

      def initialize
        @keyboard = Keyboard.new
        @mouse = Mouse.new
      end
    end
  end
end
